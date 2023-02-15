import 'dart:convert';

ResponseCategories responseCategoriesHomeFromJson(String str) =>
    ResponseCategories.fromJson(json.decode(str));

String responseCategoriesHomeToJson(ResponseCategories data) =>
    json.encode(data.toJson());

class ResponseCategories {
  ResponseCategories({
    required this.resp,
    required this.message,
    required this.categories,
  });

  bool resp;
  String message;
  List<Categoriess> categories;

  factory ResponseCategories.fromJson(Map<String, dynamic> json) =>
      ResponseCategories(
        resp: json["resp"],
        message: json["message"],
        categories: List<Categoriess>.from(
            json["listcategories"].map((x) => Categoriess.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "listcategories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Categoriess {
  Categoriess(
      {required this.uidCategory,
      required this.category,
      required this.idCategory,
      required this.idcat});

  int uidCategory;
  String category;
  int idCategory;
  int idcat;

  factory Categoriess.fromJson(Map<String, dynamic> json) => Categoriess(
        uidCategory: json["idSousCategorie"],
        category: json["nomSousCategorie"],
        idCategory: json["categorie_id"],
        idcat: json["uidCategory"],
      );

  Map<String, dynamic> toJson() => {
        "uidsubCategory": uidCategory,
        "category": category,
        "category_id": idCategory,
        "uidCategory": idcat
      };
}
