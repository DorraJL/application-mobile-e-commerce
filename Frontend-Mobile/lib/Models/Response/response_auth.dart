import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  bool resp;
  String msg;
  User? user;
  String token;

  ResponseLogin({
    required this.resp,
    required this.msg,
    this.user,
    required this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        resp: json["resp"],
        msg: json["msg"],
        user: User.fromJson(json["user"] != null ? json["user"] : Map()),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "user": user!.toJson(),
        "token": token,
      };
}

class User {
  int? uid;
  String? firstName;
  String? email;
  String? phone;
  String? rolId;
  String? token;

  User(
      {this.uid,
      this.firstName,
      this.phone,
      this.email,
      this.rolId,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
      uid: json["uid"] != null ? json["uid"] : 0,
      firstName: json["firstName"] != null ? json["firstName"] : '',
      phone: json["phone"] != null ? json["phone"] : '',
      email: json["email"] != null ? json["email"] : '',
      rolId: json["rol_id"] != null ? json["rol_id"] : '',
      token: json["token"] != null ? json["token"] : '');
  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "phone": phone,
        "email": email,
        "rol_id": rolId,
        "token": token
      };
}
