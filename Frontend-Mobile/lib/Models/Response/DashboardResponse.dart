import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  bool resp;
  String msg;
  DashboardModel dash;

  DashboardResponse({
    required this.resp,
    required this.msg,
    required this.dash,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        resp: json["resp"],
        msg: json["msg"],
        dash: DashboardModel.fromJson(json["dash"]),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msg": msg,
        "dash": dash.toJson(),
      };
}

class DashboardModel {
  int totalSoldProduct;
  int totalClients;
  int totalProducts;
  double totalSoldProductAmount;

  DashboardModel({
    required this.totalClients,
    required this.totalSoldProduct,
    required this.totalSoldProductAmount,
    required this.totalProducts,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        totalClients: json["NBClients"],
        totalSoldProduct: json["NBPro"],
        totalSoldProductAmount: double.parse(json["Revenue"].toString()),
        totalProducts: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "NBClients": totalClients,
        "NBPro": totalSoldProduct,
        "Revenue": totalSoldProductAmount,
        "Total": totalProducts,
      };
}
