import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/cart/widgets/SelectAddreessPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/Orders/orders_bloc.dart';
import '../../../Bloc/user/user_bloc.dart';
import '../../themes/colors_tech4iot.dart';
import '../../widgets/AnimationRoute.dart';
import '../../widgets/widgets.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // new StripeService()
    //   ..init();
    final orderBloc = BlocProvider.of<OrdersBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state is LoadingOrderState) {
          modalLoadingShort(context);
        } else if (state is FailureOrdersState) {
          Navigator.pop(context);
          errorMessageSnack(context, 'vueillez selectioner adresse');
          print(state.error);
        } else if (state is SuccessOrdersState) {
          Navigator.pop(context);
          modalSuccess(context, 'order recus', onPressed: () {
            productBloc.add(OnClearProductsEvent());
            Navigator.push(context, routeFade(page: HomePage()));
          });
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xfff3f4f8),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(
              text: 'Commander',
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CheckoutAddress(),
                SizedBox(height: 20.0),
                _DetailsTotal(),
                SizedBox(height: 20.0),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) => InkWell(
                        onTap: () {
                          orderBloc.add(OnAddNewOrdersEvent(
                              userBloc.state.uidAddress,
                              productBloc.state.total,
                              productBloc.product));
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const TextFrave(
                                    text: 'Total',
                                    fontSize: 19,
                                  ),
                                  TextFrave(
                                    text: '${productBloc.state.total} TND',
                                    fontSize: 19,
                                  )
                                ],
                              ),
                              BtnFrave(
                                text: 'Envoyer',
                                width: size.width,
                              ),
                            ]),
                      ),

                
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckoutAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFrave(text: 'Adresse de livraison', fontWeight: FontWeight.w500),
              InkWell(
                  onTap: () => Navigator.push(
                      context, routeFrave(page: SelectAddressPage())),
                  child: TextFrave(
                      text: 'Changer',
                      color: ColorsFrave.primaryColorFrave,
                      fontSize: 17))
            ],
          ),
          Divider(),
          SizedBox(height: 5.0),
          BlocBuilder<UserBloc, UserState>(
              builder: (_, state) => TextFrave(
                    text: (state.addressName != '')
                        ? state.addressName
                        : 'Select Adresse',
                    fontSize: 17,
                  ))
        ],
      ),
    );
  }
}

class _DetailsTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    return Container(
      padding: EdgeInsets.all(15.0),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFrave(text: 'Ordre', fontWeight: FontWeight.w500),
          Divider(),
        
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFrave(text: 'Total', fontWeight: FontWeight.w500),
              TextFrave(
                  text: '${productBloc.state.total}0 TND',
                  fontWeight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}
