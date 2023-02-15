import 'package:e_commers/Models/Response/OrdersByStatusResponse.dart';
import 'package:flutter/material.dart';

import 'package:e_commers/Service/LivraisonController.dart';

import 'package:e_commers/ui/Views/Delivery/OrderDetailsDeliveryPage.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

import '../../themes/colors_tech4iot.dart';
import '../../widgets/shimmer_frave.dart';
import '../../widgets/widgets.dart';

class ListOrdersDeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFrave(text: 'Liste des ordres'),
        centerTitle: true,
        elevation: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  size: 19, color: ColorsFrave.primaryColorFrave),
              TextFrave(
                  text: 'Retour',
                  fontSize: 17,
                  color: ColorsFrave.primaryColorFrave)
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<OrdersResponse>?>(
          future: deliveryController.getOrdersForDelivery('ENVOYE'),
          builder: (context, snapshot) => (!snapshot.hasData)
              ? Column(
                  children: [
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                  ],
                )
              : _ListOrdersForDelivery(listOrdersDelivery: snapshot.data!)),
    );
  }
}

class _ListOrdersForDelivery extends StatelessWidget {
  final List<OrdersResponse> listOrdersDelivery;

  const _ListOrdersForDelivery({required this.listOrdersDelivery});

  @override
  Widget build(BuildContext context) {
    return (listOrdersDelivery.length != 0)
        ? ListView.builder(
            itemCount: listOrdersDelivery.length,
            itemBuilder: (_, i) => CardOrdersDelivery(
                  orderResponse: listOrdersDelivery[i],
                  onPressed: () => Navigator.push(
                      context,
                      routeFrave(
                          page: OrdersDetailsDeliveryPage(
                              order: listOrdersDelivery[i]))),
                ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Center(child: ),
              SizedBox(height: 15.0),
              TextFrave(
                  text: 'Sans Ordres',
                  color: ColorsFrave.primaryColorFrave,
                  fontWeight: FontWeight.w500,
                  fontSize: 21)
            ],
          );
  }
}
