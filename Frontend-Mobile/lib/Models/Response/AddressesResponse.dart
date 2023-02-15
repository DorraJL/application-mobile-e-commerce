import 'dart:convert';

AddressesResponse addressesResponseFromJson(String str) =>
    AddressesResponse.fromJson(json.decode(str));

String addressesResponseToJson(AddressesResponse data) =>
    json.encode(data.toJson());

class AddressesResponse {
  bool resp;
  String msg;
  List<ListAddress> listAddresses;

  AddressesResponse({
    required this.resp,
    required this.msg,
    required this.listAddresses,
  });

  factory AddressesResponse.fromJson(Map<String, dynamic> json) =>
      AddressesResponse(
        resp: json["resp"],
        msg: json["msg"],
        listAddresses: List<ListAddress>.from(
            json["listAddresses"].map((x) => ListAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "listAddresses":
            List<dynamic>.from(listAddresses.map((x) => x.toJson())),
      };
}

class ListAddress {
  int id;
  String street;
  String reference;
  String latitude;
  String longitude;

  ListAddress(
      {required this.id,
      required this.street,
      required this.reference,
      required this.latitude,
      required this.longitude});

  factory ListAddress.fromJson(Map<String, dynamic> json) => ListAddress(
      id: json["id"],
      street: json["Rue"],
      reference: json["reference"],
      latitude: json["Latitude"],
      longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "Rue": street,
        "reference": reference,
        "latitude": latitude,
        "longitude": longitude
      };
}
