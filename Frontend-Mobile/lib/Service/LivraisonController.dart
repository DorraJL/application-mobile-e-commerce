import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/GetAllDeliveryResponse.dart';
import 'package:e_commers/Models/Response/OrdersByStatusResponse.dart';
import 'package:e_commers/Service/urls.dart';

class DeliveryController {
  Future<List<Delivery>?> getAlldelivery() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/order/get-all-delivery'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return GetAllDeliveryResponse.fromJson(jsonDecode(resp.body)).delivery;
  }

  Future<List<OrdersResponse>?> getOrdersForDelivery(String statusOrder) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse(
            '${URLS.urlApi}/order/get-all-orders-by-delivery/' + statusOrder),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return OrdersByStatusResponse.fromJson(jsonDecode(resp.body))
        .ordersResponse;
  }
}

final deliveryController = DeliveryController();
