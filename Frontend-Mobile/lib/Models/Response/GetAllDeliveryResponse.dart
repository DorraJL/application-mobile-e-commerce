import 'dart:convert';

GetAllDeliveryResponse getAllDeliveryResponseFromJson(String str) =>
    GetAllDeliveryResponse.fromJson(json.decode(str));

String getAllDeliveryResponseToJson(GetAllDeliveryResponse data) =>
    json.encode(data.toJson());

class GetAllDeliveryResponse {
  bool? resp;
  String? msg;
  List<Delivery>? delivery;

  GetAllDeliveryResponse({
    this.resp,
    this.msg,
    this.delivery,
  });

  factory GetAllDeliveryResponse.fromJson(Map<String, dynamic> json) =>
      GetAllDeliveryResponse(
        resp: json["resp"],
        msg: json["msg"],
        delivery: List<Delivery>.from(
            json["delivery"].map((x) => Delivery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "delivery": List<dynamic>.from(delivery!.map((x) => x.toJson())),
      };
}

class Delivery {
  int? personId;
  String? nameDelivery;
  String? phone;
  String? notificationToken;

  Delivery(
      {this.personId, this.nameDelivery, this.phone, this.notificationToken});

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
      personId: json["user_id"],
      nameDelivery: json["nomLivreur"],
      phone: json["telephone"],
      notificationToken: json["token"]);

  Map<String, dynamic> toJson() => {
        "user_id": personId,
        "nomLivreur": nameDelivery,
        "telephone": phone,
        "token": notificationToken
      };
}
