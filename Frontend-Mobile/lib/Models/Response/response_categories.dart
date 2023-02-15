import 'dart:convert';

ResponseCategorieHome responseCategorieHomeFromJson(String str) =>
    ResponseCategorieHome.fromJson(json.decode(str));

String responseCategorieHomeToJson(ResponseCategorieHome data) =>
    json.encode(data.toJson());

class ResponseCategorieHome {
  ResponseCategorieHome({
    required this.resp,
    required this.message,
    required this.categorie,
  });

  bool resp;
  String message;
  List<Categorie> categorie;

  factory ResponseCategorieHome.fromJson(Map<String, dynamic> json) =>
      ResponseCategorieHome(
        resp: json["resp"],
        message: json["message"],
        categorie: List<Categorie>.from(
            json["categories"].map((x) => Categorie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "categories": List<dynamic>.from(categorie.map((x) => x.toJson())),
      };
}

class Categorie {
  Categorie({
    required this.uidCategory,
    required this.category,
  });

  int uidCategory;
  String category;

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie(
        uidCategory: json["idCategorie"],
        category: json["nomCategorie"],
      );

  Map<String, dynamic> toJson() => {
        "idCategorie": uidCategory,
        "nomCategorie": category,
      };
}
