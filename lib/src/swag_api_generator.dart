import 'dart:convert';
import 'dart:io';

import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:codo_gen_swagger/src/swag_api_method.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class SwagApiGenerator extends GeneratorForAnnotation<SwagCodoGen> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final configFile = File('./lib/swagger.json');
    final jsonString = await configFile.readAsString();
    final dynamic jsonMap = jsonDecode(jsonString);

    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final className = '${visitor.className}Gen';

    final classBuffer = StringBuffer();

    final host = annotation.read('host').stringValue;
    classBuffer.writeln(" import 'package:http/http.dart' as http;");

    generateError(classBuffer);

    final nameApiclass = '''
        class $className {
          final SharedPreferences prf;
          $className({
            required this.prf,
          });
          ''';
    classBuffer.writeln(nameApiclass);
    final jsonData = jsonMap['paths'] as Map<String, dynamic>;
    jsonData.forEach((key, value) {
      final method = value.keys.first;
      var params = parseParametrs(value.values.first);
      classBuffer.writeln('/// params ' + params.toString());
      classBuffer.writeln('/// method name ' + method.toString());
      genereteClassApi(
          host, key.toString(), method.toString(), classBuffer, params);
    });

    classBuffer.writeln('}');
    return classBuffer.toString();
  }

  List<String> parseParametrs(Map<String, dynamic> data) {
    bool containsParams = data.containsKey('parameters');
    if (!containsParams) {
      return [];
    }
    return [
      data['parameters'][0]['name'],
      data['parameters'][0]['in'],
    ];
  }

  void generateGettersAndSetters(
      ModelVisitor visitor, StringBuffer classBuffer) {
    // 1
    for (final field in visitor.fields.keys) {
      // 2
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;

      // 3
      classBuffer.writeln(
          "${visitor.fields[field]} get $variable => variables['$variable'];");
      // EX: String get name => variables['name'];

      // 4
      classBuffer
          .writeln('set $variable(${visitor.fields[field]} $variable) {');
      classBuffer.writeln('super.$field = $variable;');
      classBuffer.writeln("variables['$variable'] = $variable;");
      classBuffer.writeln('}');

      // EX: set name(String name) {
      //       super._name = name;
      //       variables['name'] = name;
      //     }
    }
  }

  void generateError(StringBuffer classBuffer) {
    const errorClass = '''class ServerException implements Exception {
          final String message;
          ServerException({required this.message});
        }
        ''';
    classBuffer.writeln(errorClass);
  }

  void genereteClassApi(String host, String path, String method,
      StringBuffer classBuffer, List<String> params) {
    final startRemove = path.indexOf('{');
    final endRemove = path.indexOf('}');
    if (startRemove > 0) {
      path = path.substring(0, startRemove - 1);
    }

    var nameUrl = path.split('/').last;
    var literalIndex = nameUrl.indexOf('-');
    while (literalIndex > 0) {
      if (literalIndex > 0) {
        final upSymbol = nameUrl[literalIndex + 1].toUpperCase();
        nameUrl = nameUrl.substring(0, literalIndex) +
            upSymbol +
            nameUrl.substring((literalIndex + 2), nameUrl.length);
        literalIndex = nameUrl.indexOf('-');
      }
    }

    var funcPathParam = '';
    var supplementUri = '';
    var bodyParam = <String>['', '', ''];

    if (params.isNotEmpty) {
      if (params[1] == 'path') {
        funcPathParam = 'String ${params[0]},';
        supplementUri = '/\$${params[0]}';
      } else {
        bodyParam[0] = 'Map<String,dynamic> body,';
        bodyParam[1] = 'final b = utf8.encode(json.encode(body));';
        bodyParam[2] = 'body:b,';
      }
    }

    final text = """


          Future<T> $nameUrl<T>($funcPathParam ${bodyParam[0]} T Function(dynamic json) mapper,) async {
            
            var url = Uri.parse(
              '$path$supplementUri',
            );
            ${bodyParam[1]}

            var response = await http.$method(url,${bodyParam[2]} headers: {
              'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
            });
            final data = json.decode(utf8.decode(response.bodyBytes));
            if (response.statusCode == 200) {
              return mapper(data);
            }
            throw ServerException(message: data['message']);
          }
        """;
    classBuffer.writeln(text);
  }
}
