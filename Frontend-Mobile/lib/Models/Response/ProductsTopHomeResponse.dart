import 'dart:convert';

ProductsTopHomeResponse productsTopHomeResponseFromJson(String str) =>
    ProductsTopHomeResponse.fromJson(json.decode(str));

String productsTopHomeResponseToJson(ProductsTopHomeResponse data) =>
    json.encode(data.toJson());

class ProductsTopHomeResponse {
  bool resp;
  String msg;
  List<Productsdb> productsdb;

  ProductsTopHomeResponse({
    required this.resp,
    required this.msg,
    required this.productsdb,
  });

  factory ProductsTopHomeResponse.fromJson(Map<String, dynamic> json) =>
      ProductsTopHomeResponse(
        resp: json["resp"],
        msg: json["msg"],
        productsdb: List<Productsdb>.from(
            json["productsdb"].map((x) => Productsdb.fromJson(x))).toList(),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "productsdb": List<dynamic>.from(productsdb.map((x) => x.toJson())),
      };
}

class Productsdb {
  int uidProduct;
  String nameProduct;
  String description;
  double price;
  int status;
  String picture;
  String category;
  int categoryId;

  Productsdb(
      {required this.uidProduct,
      required this.nameProduct,
      required this.description,
      required this.price,
      required this.status,
      required this.picture,
      required this.category,
      required this.categoryId});

  factory Productsdb.fromJson(Map<String, dynamic> json) => Productsdb(
      uidProduct: json["idProduit"],
      nameProduct: json["nomProduit"],
      description: json["description"],
      price: json["prix"].toDouble(),
      status: json["status"],
      picture: json["image"],
      category: json["category"],
      categoryId: json["category_id"]);

  Map<String, dynamic> toJson() => {
        "uidProduct": uidProduct,
        "nameProduct": nameProduct,
        "description": description,
        "price": price,
        "status": status,
        "picture": picture,
        "category": category,
        "category_id": categoryId
      };
}
