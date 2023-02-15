import 'dart:convert';

ResponseUser responseUserFromJson(String str) =>
    ResponseUser.fromJson(json.decode(str));

String responseUserToJson(ResponseUser data) => json.encode(data.toJson());

class ResponseUser {
  ResponseUser({
    required this.resp,
    required this.message,
    required this.users,
  });

  bool resp;
  String message;
  List<ListUsers> users;

  factory ResponseUser.fromJson(Map<String, dynamic> json) => ResponseUser(
        resp: json["resp"],
        message: json["message"],
        users: List<ListUsers>.from(
            json["users"].map((x) => ListUsers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class ListUsers {
  ListUsers({
    required this.uid,
    required this.firstName,
    required this.phone,
    required this.email,
    required this.rolId,
  });

  int uid;
  String firstName;
  String email;
  String phone;
  String rolId;

  factory ListUsers.fromJson(Map<String, dynamic> json) => ListUsers(
        uid: json["id"] ?? 0,
        firstName: json["nom"] ?? "",
        phone: json["telephone"] ?? '',
        email: json["email"] ?? '',
        rolId: json["role"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": uid,
        "nom": firstName,
        "telephone": phone,
        "email": email,
        "role": rolId,
      };
}
