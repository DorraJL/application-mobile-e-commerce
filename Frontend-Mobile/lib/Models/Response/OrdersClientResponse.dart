import 'dart:convert';

OrdersClientResponse ordersClientResponseFromJson(String str) =>
    OrdersClientResponse.fromJson(json.decode(str));

String ordersClientResponseToJson(OrdersClientResponse data) =>
    json.encode(data.toJson());

class OrdersClientResponse {
  bool? resp;
  String? msg;
  List<OrdersClient> ordersClient;

  OrdersClientResponse({
    this.resp,
    this.msg,
    required this.ordersClient,
  });

  factory OrdersClientResponse.fromJson(Map<String, dynamic> json) =>
      OrdersClientResponse(
        resp: json["resp"],
        msg: json["msg"],
        ordersClient: List<OrdersClient>.from(
            json["ordersClient"].map((x) => OrdersClient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "ordersClient": List<dynamic>.from(ordersClient.map((x) => x.toJson())),
      };
}

class OrdersClient {
  int? id;
  int? clientId;
  int? deliveryId;
  String? reference;
  String? latClient;
  String? lngClient;
  String? delivery;
  String? deliveryPhone;
  int? addressId;
  String? latitude;
  String? longitude;
  String? status;
  double? amount;
  DateTime? currentDate;

  OrdersClient({
    this.id,
    this.clientId,
    this.deliveryId,
    this.reference,
    this.latClient,
    this.lngClient,
    this.delivery,
    this.deliveryPhone,
    this.addressId,
    this.latitude,
    this.longitude,
    this.status,
    this.amount,
    this.currentDate,
  });

  factory OrdersClient.fromJson(Map<String, dynamic> json) => OrdersClient(
        id: json["id"],
        clientId: json["client_id"],
        deliveryId: json["livreur_id"] == null ? 0 : json["livreur_id"],
        delivery: json["livreur"] == null ? '' : json["livreur"],
        deliveryPhone:
            json["livreurPhone"] == '' ? null : json["livreurPhone"],
        addressId: json["address_id"],
        reference: json["reference"],
        latClient: json["latClient"],
        lngClient: json["lngClient"],
        latitude: json["latitude"] == '' ? null : json["latitude"],
        longitude: json["longitude"] == '' ? null : json["longitude"],
        status: json["status"],
        amount: json["amount"].toDouble(),
        currentDate: DateTime.parse(json["currentDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "livreur_id": deliveryId == null ? null : deliveryId,
        "livreur": delivery == null ? null : delivery,
        "livreurPhone": deliveryPhone == null ? null : deliveryPhone,
        "address_id": addressId,
        "reference": reference,
        "latClient": latClient,
        "lngClient": lngClient,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "amount": amount,
        "currentDate": currentDate!.toIso8601String(),
      };
}
