import 'dart:convert';

OrdersByStatusResponse ordersByStatusResponseFromJson(String str) =>
    OrdersByStatusResponse.fromJson(json.decode(str));

String ordersByStatusResponseToJson(OrdersByStatusResponse data) =>
    json.encode(data.toJson());

class OrdersByStatusResponse {
  bool resp;
  String msg;
  List<OrdersResponse>? ordersResponse;

  OrdersByStatusResponse({
    required this.resp,
    required this.msg,
    required this.ordersResponse,
  });

  factory OrdersByStatusResponse.fromJson(Map<String, dynamic> json) =>
      OrdersByStatusResponse(
        resp: json["resp"],
        msg: json["msg"],
        ordersResponse: List<OrdersResponse>.from(
            json["ordersResponse"].map((x) => OrdersResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "ordersResponse":
            List<dynamic>.from(ordersResponse!.map((x) => x.toJson())),
      };
}

class OrdersResponse {
  int? orderId;
  int? deliveryId;
  String? delivery;

  int? clientId;
  String? cliente;

  String? clientPhone;
  int? addressId;
  String? street;
  String? reference;
  String? latitude;
  String? longitude;
  String? status;
  double? amount;
  DateTime? currentDate;

  OrdersResponse({
    this.orderId,
    this.deliveryId,
    this.delivery,
    this.clientId,
    this.cliente,
    this.clientPhone,
    this.addressId,
    this.street,
    this.reference,
    this.latitude,
    this.longitude,
    this.status,
    this.amount,
    this.currentDate,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) => OrdersResponse(
        orderId: json["order_id"],
        deliveryId: json["livreur_id"] ?? 0,
        delivery: json["livreur"] ?? '-',
        clientId: json["client_id"],
        cliente: json["cliente"],
        clientPhone: json["clientPhone"] ?? '-',
        addressId: json["address_id"],
        street: json["Rue"],
        reference: json["reference"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        status: json["status"],
        amount: json["amount"].toDouble(),
        currentDate: DateTime.parse(json["currentDate"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "livreur_id": deliveryId,
        "livreur": delivery,
        "client_id": clientId,
        "cliente": cliente,
        "clientPhone": clientPhone,
        "address_id": addressId,
        "Rue": street,
        "reference": reference,
        "Latitude": latitude,
        "Longitude": longitude,
        "status": status,
        "amount": amount,
        "currentDate": currentDate!.toIso8601String(),
      };
}
