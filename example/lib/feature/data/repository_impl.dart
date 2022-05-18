import 'package:http/http.dart' as http;

import '../../swag_api.dart';
import '../domail/user.dart';

class RepositoryImpl extends SwagApiGen {
  RepositoryImpl({required super.prf});

  Future<List<UserModel>> getUsers() async {
    return accounts<List<UserModel>>(
      ((json) => (json as List).map((e) => UserModel.fromJson(e)).toList()),
    );
  }

  Future<UserModel> getUser() async {
    return accounts<UserModel>((json) => UserModel.fromJson(json));
  }
}
