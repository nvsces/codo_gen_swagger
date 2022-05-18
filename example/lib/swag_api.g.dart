// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swag_api.dart';

// **************************************************************************
// SwagApiGenerator
// **************************************************************************

import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class SwagApiGen {
  final SharedPreferences prf;
  SwagApiGen({
    required this.prf,
  });

  /// params []
  /// method name get

  Future<T> accounts<T>(
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/profile/accounts',
    );

    var response = await http.get(url, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> addAccount<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/profile/add-account',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [email, path]
  /// method name get

  Future<T> changeEmail<T>(
    String email,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/profile/change-email/$email',
    );

    var response = await http.get(url, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [phone, path]
  /// method name get

  Future<T> changePhone<T>(
    String phone,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/profile/change-phone/$phone',
    );

    var response = await http.get(url, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [account, path]
  /// method name get

  Future<T> delete<T>(
    String account,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/profile/delete/$account',
    );

    var response = await http.get(url, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [account, path]
  /// method name get

  Future<T> address<T>(
    String account,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/service/address/$account',
    );

    var response = await http.get(url, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> matchEmailAccount<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/api/service/match-email-account',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> changePassword<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/change-password',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> confirmRegistr<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/confirm-registr',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> recoveryCofirm<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/recovery-cofirm',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> recoveryPassword<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/recovery-password',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> signIn<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/sign-in',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }

  /// params [input, body]
  /// method name post

  Future<T> signUp<T>(
    Map<String, dynamic> body,
    T Function(dynamic json) mapper,
  ) async {
    var url = Uri.parse(
      '/auth/sign-up',
    );
    final b = utf8.encode(json.encode(body));

    var response = await http.post(url, body: b, headers: {
      'authorization': 'Bearer ' + (prf.getString('token') ?? ''),
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return mapper(data);
    }
    throw ServerException(message: data['message']);
  }
}
