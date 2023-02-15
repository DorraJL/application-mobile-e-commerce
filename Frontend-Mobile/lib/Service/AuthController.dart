import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/Models/Response/response_auth.dart';

class AuthServices {
  Future<ResponseLogin> loginController(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('${URLS.urlApi}/auth/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'passwordd': password});
    print(jsonDecode(response.body));
    return ResponseLogin.fromJson(jsonDecode(response.body));
  }

  Future<ResponseLogin> renewLoginController() async {
    final token = await secureStorage.readToken();

    final response = await http.get(
        Uri.parse('${URLS.urlApi}/auth/renew-login'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(response.body));
    return ResponseLogin.fromJson(jsonDecode(response.body));
  }
}

final authServices = AuthServices();
