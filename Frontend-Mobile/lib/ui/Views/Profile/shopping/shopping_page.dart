import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_commers/Service/OrderController.dart';
import 'package:e_commers/Helpers/Date.dart';
import 'package:e_commers/ui/Views/Profile/shopping/order_details_page.dart';
import 'package:e_commers/Models/Response/OrdersClientResponse.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

import '../../../widgets/shimmer_frave.dart';

class ClientOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: 'Mes Ordres', fontSize: 20),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColorFrave, size: 17),
              TextFrave(
                  text: 'Retour',
                  fontSize: 17,
                  color: ColorsFrave.primaryColorFrave)
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersClient>>(
          future: ordersController.getListOrdersForClient(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _ListOrdersClient(listOrders: snapshot.data!);
            }
          }),
    );
  }
}

class _ListOrdersClient extends StatelessWidget {
  final List<OrdersClient> listOrders;

  const _ListOrdersClient({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return (listOrders.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            itemCount: listOrders.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  routeFrave(
                      page:
                          ClientDetailsOrderPage(orderClient: listOrders[i]))),
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFrave(
                            text: 'ORDRE # ${listOrders[i].id}',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsFrave.primaryColorFrave),
                        TextFrave(
                            text: listOrders[i].status!,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: (listOrders[i].status == 'LIVRE')
                                ? Colors.green
                                : (listOrders[i].status == 'EN ROUTE')
                                    ? ColorsFrave.secundaryColorFrave
                                    : ColorsFrave.primaryColorFrave),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFrave(
                            text: 'MONTANT',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextFrave(
                            text: '${listOrders[i].amount}0 TND', fontSize: 16)
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFrave(
                            text: 'DATE',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        TextFrave(
                            text: DateFrave.getDateOrder(
                                listOrders[i].currentDate.toString()),
                            fontSize: 15)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : ShimmerFrave();
  }
}
