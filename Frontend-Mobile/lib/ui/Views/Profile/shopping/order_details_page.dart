import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Helpers/Date.dart';
import '../../../../Models/Response/OrderDetailsResponse.dart';
import '../../../../Models/Response/OrdersClientResponse.dart';
import '../../../../Service/OrderController.dart';
import '../../../../Service/urls.dart';
import '../../../themes/colors_tech4iot.dart';
import '../../../widgets/AnimationRoute.dart';
import '../../../widgets/shimmer_frave.dart';
import '../../Profile/widgets/ClientMapPage.dart';

class ClientDetailsOrderPage extends StatelessWidget {
  final OrdersClient orderClient;

  const ClientDetailsOrderPage({required this.orderClient});

  void accessGps(PermissionStatus status, BuildContext context) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacement(
            context, routeFrave(page: ClientMapPage(orderClient: orderClient)));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(
            text: 'ORDRE # ${orderClient.id}',
            fontSize: 17,
            fontWeight: FontWeight.w500),
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
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10.0),
            child: TextFrave(
                text: orderClient.status!,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: (orderClient.status == 'LIVRE')
                    ? Colors.green
                    : (orderClient.status == 'EN ROUTE')
                        ? ColorsFrave.secundaryColorFrave
                        : ColorsFrave.primaryColorFrave),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: FutureBuilder<List<DetailsOrder>?>(
                  future: ordersController
                      .gerOrderDetailsById(orderClient.id.toString()),
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
                      : _ListProductsDetails(
                          listProductDetails: snapshot.data!))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFrave(
                        text: 'TOTAL',
                        fontWeight: FontWeight.w500,
                        color: ColorsFrave.primaryColorFrave),
                    TextFrave(
                        text: '${orderClient.amount} TND',
                        fontWeight: FontWeight.w500),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFrave(
                        text: 'Livreur',
                        fontWeight: FontWeight.w500,
                        color: ColorsFrave.primaryColorFrave,
                        fontSize: 17),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(width: 10.0),
                        TextFrave(
                            text: (orderClient.deliveryId != 0)
                                ? orderClient.delivery!
                                : 'Non assigné',
                            fontSize: 17),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFrave(
                        text: 'Date',
                        fontWeight: FontWeight.w500,
                        color: ColorsFrave.primaryColorFrave,
                        fontSize: 17),
                    TextFrave(
                        text: DateFrave.getDateOrder(
                            orderClient.currentDate.toString()),
                        fontSize: 16),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFrave(
                        text: 'Adresse',
                        fontWeight: FontWeight.w500,
                        color: ColorsFrave.primaryColorFrave,
                        fontSize: 16),
                    TextFrave(text: orderClient.reference!, fontSize: 16),
                  ],
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          (orderClient.status == 'EN ROUTE')
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  child: BtnFrave(
                    text: 'suivre livraison',
                    onPressed: () async =>
                        accessGps(await Permission.location.request(), context),
                    width: 200,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class _ListProductsDetails extends StatelessWidget {
  final List<DetailsOrder> listProductDetails;

  const _ListProductsDetails({required this.listProductDetails});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: listProductDetails.length,
      separatorBuilder: (_, index) => Divider(),
      itemBuilder: (_, i) => Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          URLS.baseUrl + listProductDetails[i].picture!))),
            ),
            SizedBox(width: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFrave(
                    text: listProductDetails[i].nameProduct!,
                    fontWeight: FontWeight.w500),
                SizedBox(height: 5.0),
                TextFrave(
                    text: 'Quantity: ${listProductDetails[i].quantity}',
                    color: Colors.grey,
                    fontSize: 17),
              ],
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: TextFrave(text: '${listProductDetails[i].total} TND'),
            ))
          ],
        ),
      ),
    );
  }
}
