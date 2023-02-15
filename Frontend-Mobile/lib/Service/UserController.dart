import 'dart:convert';
import 'package:e_commers/Models/Response/DashboardResponse.dart';
import 'package:e_commers/Service/PushNotification.dart';
import 'package:e_commers/ui/Views/admin/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/response_auth.dart';
import 'package:e_commers/Models/Response/response_default.dart';

import '../Models/Response/AddressOneResponse.dart';
import '../Models/Response/AddressesResponse.dart';
import '../Models/Response/response_auth.dart';
import '../Models/Response/response_user.dart';

class UserServices {
/*
  Future<ResponseDefault> updateNotificationToken() async {
    final token = await secureStorage.readToken();
    final nToken = await pushNotification.getNotificationToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/update-notification-token'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'token': nToken});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }*/

  Future<User?> getUserById() async {
    final token = await secureStorage.readToken();

    final response = await http.get(
        Uri.parse('${URLS.urlApi}/user/get-user-by-id'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(response.body));
    return ResponseLogin.fromJson(jsonDecode(response.body)).user;
  }

  Future<List<ListUsers>> getListUsers() async {
    final token = await secureStorage.readToken();

    final response = await http.get(
        Uri.parse('${URLS.urlApi}/user/get-all-users'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!});
    print(jsonDecode(response.body));
    return ResponseUser.fromJson(jsonDecode(response.body)).users;
  }

  Future<ResponseDefault> changePassword(
      String currentPassword, String newPassword) async {
    final token = await secureStorage.readToken();

    final response = await http.put(
        Uri.parse('${URLS.urlApi}/user/change-password'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'currentPassword': currentPassword, 'newPassword': newPassword});
    print(jsonDecode(response.body));
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseDefault> deleteUser(String idUser) async {
    final token = await secureStorage.readToken();

    final resp = await http.delete(
        Uri.parse('${URLS.urlApi}/user/delete-user/' + idUser),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<AddressOneResponse> getAddressOne() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/user/get-address'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return AddressOneResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DashboardModel> dashboard() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${URLS.urlApi}/user/get-dash'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return DashboardResponse.fromJson(jsonDecode(resp.body)).dash;
  }

  Future<List<ListAddress>> getAddresses() async {
    final token = await secureStorage.readToken();

    final response = await http.get(
        Uri.parse('${URLS.urlApi}/user/get-addresses'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(response.body));
    return AddressesResponse.fromJson(jsonDecode(response.body)).listAddresses;
  }

  Future<ResponseDefault> updateStreetAddress(
      String address, String reference) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/user/update-street-address'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'address': address, 'reference': reference});
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> registerClient(
      String name, String phone, String email, String passwordd) async {
    final resp = await http
        .post(Uri.parse('${URLS.urlApi}/user/register-client'), headers: {
      'Accept': 'application/json'
    }, body: {
      'username': name,
      'phone': phone,
      'email': email,
      'passwordd': passwordd
    });

    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> registerUser(String name, String phone, String email,
      String passwordd, String rol_id) async {
    final resp = await http
        .post(Uri.parse('${URLS.urlApi}/user/add-new-user'), headers: {
      'Accept': 'application/json'
    }, body: {
      'username': name,
      'phone': phone,
      'email': email,
      'passwordd': passwordd,
      'rol_id': rol_id
    });

    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> deleteStreetAddress(String idAddress) async {
    final token = await secureStorage.readToken();

    final resp = await http.delete(
        Uri.parse('${URLS.urlApi}/delete-street-address/' + idAddress),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> addNewAddressLocation(String street, String reference,
      String latitude, String longitude) async {
    final token = await secureStorage.readToken();

    final resp = await http
        .post(Uri.parse('${URLS.urlApi}/user/add-new-address'), headers: {
      'Accept': 'application/json',
      'xxx-token': token!
    }, body: {
      'street': street,
      'reference': reference,
      'latitude': latitude,
      'longitude': longitude
    });
    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> editProfile(
      String name, String phone, String email) async {
    final token = await secureStorage.readToken();

    final response = await http.put(
        Uri.parse('${URLS.urlApi}/user/edit-profile'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'firstname': name, 'phone': phone, 'email': email});
    print(jsonDecode(response.body));
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }
/*
  Future<List<String>> getAdminsNotificationToken() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/get-admins-notification-token'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return List<String>.from(jsonDecode(resp.body));
  }*/

  Future<ResponseDefault> updateDeliveryToClient(String idPerson) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
      Uri.parse('${URLS.urlApi}/update-delivery-to-client/' + idPerson),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }
}

final userServices = UserServices();
