import 'dart:convert';

ResponseCategoriesHome responseCategoriesHomeFromJson(String str) =>
    ResponseCategoriesHome.fromJson(json.decode(str));

String responseCategoriesHomeToJson(ResponseCategoriesHome data) =>
    json.encode(data.toJson());

class ResponseCategoriesHome {
  ResponseCategoriesHome({
    required this.resp,
    required this.message,
    required this.categories,
  });

  bool resp;
  String message;
  List<Categories> categories;

  factory ResponseCategoriesHome.fromJson(Map<String, dynamic> json) =>
      ResponseCategoriesHome(
        resp: json["resp"],
        message: json["message"],
        categories: List<Categories>.from(
            json["categories"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Categories {
  Categories(
      {required this.uidCategory,
      required this.category,
      required this.idCategory});

  int uidCategory;
  String category;
  int idCategory;
  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        uidCategory: json["idSousCategorie"],
        category: json["nomSousCategorie"],
        idCategory: json["categorie_id"],
      );

  Map<String, dynamic> toJson() => {
        "idSousCategorie": uidCategory,
        "nomSousCategorie": category,
        "categorie_id": idCategory,
      };
}
