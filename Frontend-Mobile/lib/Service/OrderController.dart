import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/Models/Response/OrderDetailsResponse.dart';
import 'package:e_commers/Models/Response/OrdersByStatusResponse.dart';
import 'package:e_commers/Models/Response/OrdersClientResponse.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Service/urls.dart';

class OrdersController {
  Future<ResponseDefault> addNewOrders(
      int uidAddress, double total, List<ProductCart> products) async {
    final token = await secureStorage.readToken();

    Map<String, dynamic> data = {
      "uidAddress": uidAddress,
      "total": total,
      "products": products
    };

    final body = json.encode(data);

    print(body);

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/order/add-new-orders'),
        headers: {'Content-type': 'application/json', 'xxx-token': token!},
        body: body);
    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<List<OrdersResponse>?> getOrdersByStatus(String status) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/order/get-orders-by-status/' + status),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );
    print(jsonDecode(resp.body));
    return OrdersByStatusResponse.fromJson(jsonDecode(resp.body))
        .ordersResponse;
  }

  Future<List<DetailsOrder>?> gerOrderDetailsById(String idOrder) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/order/get-details-order-by-id/' + idOrder),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return OrderDetailsResponse.fromJson(jsonDecode(resp.body)).detailsOrder;
  }

  Future<ResponseDefault> updateStatusOrderToDispatched(
      String idOrder, String idDelivery) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/order/update-status-order-dispatched'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'idDelivery': idDelivery, 'idOrder': idOrder});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> updateOrderStatusOnWay(
      String idOrder, String latitude, String longitude) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${URLS.urlApi}/order/update-status-order-on-way/' + idOrder),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'latitude': latitude, 'longitude': longitude});
    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> updateOrderStatusDelivered(String idOrder) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
      Uri.parse(
          '${URLS.urlApi}/order/update-status-order-delivered/' + idOrder),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<List<OrdersClient>> getListOrdersForClient() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/client/get-list-orders-for-client'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return OrdersClientResponse.fromJson(jsonDecode(resp.body)).ordersClient;
  }
}

final ordersController = OrdersController();
