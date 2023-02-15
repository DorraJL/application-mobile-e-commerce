import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/Orders/orders_bloc.dart';
import 'package:e_commers/Service/OrderController.dart';
import 'package:e_commers/Helpers/Date.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/OrderDetailsResponse.dart';
import 'package:e_commers/Models/Response/OrdersByStatusResponse.dart';
import 'package:e_commers/ui/Views/admin/OrdersAdminPage.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

import '../../widgets/shimmer_frave.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrdersResponse order;

  const OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is LoadingOrderState) {
          modalLoadingShort(context);
        } else if (state is SuccessOrdersState) {
          Navigator.pop(context);
          modalSucces(
              context,
              'ENVOYE',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: OrdersAdminPage())));
        } else if (state is FailureOrdersState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: TextFrave(text: state.error, color: Colors.white),
              backgroundColor: Colors.red));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextFrave(text: 'Ordre N° ${order.orderId}'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    size: 17, color: ColorsFrave.primaryColorFrave),
                TextFrave(
                    text: 'Retour',
                    color: ColorsFrave.primaryColorFrave,
                    fontSize: 17)
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: FutureBuilder<List<DetailsOrder>?>(
                    future: ordersController
                        .gerOrderDetailsById(order.orderId.toString()),
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
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFrave(
                          text: 'Total',
                          color: ColorsFrave.secundaryColorFrave,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                      TextFrave(
                          text: '\$ ${order.amount}0',
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFrave(
                          text: 'Client:',
                          color: ColorsFrave.secundaryColorFrave,
                          fontSize: 16),
                      TextFrave(text: '${order.cliente}'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFrave(
                          text: 'Date:',
                          color: ColorsFrave.secundaryColorFrave,
                          fontSize: 16),
                      TextFrave(
                          text: DateFrave.getDateOrder(
                              order.currentDate.toString()),
                          fontSize: 16),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFrave(
                      text: 'Adresse de livraison:',
                      color: ColorsFrave.secundaryColorFrave,
                      fontSize: 16),
                  SizedBox(height: 5.0),
                  TextFrave(text: order.reference!, fontSize: 16),
                  SizedBox(height: 5.0),
                  (order.status == 'ENVOYE')
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFrave(
                                text: 'Livreur',
                                fontSize: 17,
                                color: ColorsFrave.secundaryColorFrave),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(width: 10.0),
                                TextFrave(text: order.delivery!, fontSize: 17)
                              ],
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            )),
            (order.status == 'ENVOYE')
                ? Container(
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BtnFrave(
                          text: 'Selectionner livreur',
                          onPressed: () => modalSelectDelivery(
                              context, order.orderId.toString()),
                          width: 200,
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
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
              child: TextFrave(text: '\$ ${listProductDetails[i].total}'),
            ))
          ],
        ),
      ),
    );
  }
}
