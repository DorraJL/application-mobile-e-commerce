import 'package:e_commers/ui/Views/admin/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commers/Service/OrderController.dart';
import 'package:e_commers/Helpers/Date.dart';
//import 'package:e_commers/Models/Stripe/PayType.dart';
import 'package:e_commers/Models/Response/OrdersByStatusResponse.dart';
import 'package:e_commers/ui/Views/admin/OrderDetailsPage.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:e_commers/Helpers/helpers.dart';
import '../../widgets/shimmer_frave.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class OrdersAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;
    final List<String> payType = ['ENVOYE', 'ANNULE', 'EN ROUTE', 'LIVRE'];
    return DefaultTabController(
        length: payType.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Liste Ordres',
              style: TextStyle(color: textColor),
            ),
            iconTheme: IconThemeData(color: mainColor),
            backgroundColor: secColor,
            centerTitle: true,
            bottom: TabBar(
                indicatorWeight: 2,
                labelColor: ColorsFrave.primaryColorFrave,
                unselectedLabelColor: Colors.grey,
                indicator: FraveIndicatorTabBar(),
                isScrollable: true,
                tabs: List<Widget>.generate(
                    payType.length,
                    (i) => Tab(
                        child: Text(payType[i],
                            style:
                                GoogleFonts.getFont('Roboto', fontSize: 17))))),
          ),
          drawer: MyDrawer(),
          body: TabBarView(
            children: payType
                .map((e) => FutureBuilder<List<OrdersResponse>?>(
                    future: ordersController.getOrdersByStatus(e),
                    builder: (context, snapshot) => (!snapshot.hasData)
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : _ListOrders(listOrders: snapshot.data!)))
                .toList(),
          ),
        ));
  }
}

class _ListOrders extends StatelessWidget {
  final List<OrdersResponse> listOrders;

  const _ListOrders({required this.listOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOrders.length,
      itemBuilder: (context, i) => _CardOrders(orderResponse: listOrders[i]),
    );
  }
}

class _CardOrders extends StatelessWidget {
  final OrdersResponse orderResponse;

  const _CardOrders({required this.orderResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(color: Colors.blueGrey, blurRadius: 8, spreadRadius: -5)
          ]),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: () => Navigator.push(
            context, routeFrave(page: OrderDetailsPage(order: orderResponse))),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFrave(text: 'ORDRE ID: ${orderResponse.orderId}'),
              Divider(),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(
                      text: 'Date',
                      fontSize: 16,
                      color: ColorsFrave.primaryColorFrave),
                  TextFrave(
                      text: DateFrave.getDateOrder(
                          orderResponse.currentDate.toString()),
                      fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFrave(
                      text: 'Client',
                      fontSize: 16,
                      color: ColorsFrave.primaryColorFrave),
                  TextFrave(text: orderResponse.cliente!, fontSize: 16),
                ],
              ),
              SizedBox(height: 10.0),
              TextFrave(
                  text: 'Adresse de livraison',
                  fontSize: 16,
                  color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              Align(
                  alignment: Alignment.centerRight,
                  child:
                      TextFrave(text: orderResponse.reference!, fontSize: 16)),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
