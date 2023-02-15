import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Models/product.dart';
import 'package:e_commers/ui/Views/Products/widgets/app_bar_product.dart';
import 'package:e_commers/ui/Views/Products/widgets/cover_product.dart';
import 'package:e_commers/ui/Views/Products/widgets/rating_product.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailsProductPage extends StatefulWidget {
  final ListProducts product;

  DetailsProductPage({required this.product});

  @override
  State<DetailsProductPage> createState() => _DetailsProductPageState();
}

class _DetailsProductPageState extends State<DetailsProductPage> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoadingShort(context);
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          setState(() {});
        } else if (state is SetAddProductToCartState) {
          modalSuccess(context, 'succes',
              onPressed: () => Navigator.pop(context));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.only(top: 10.0, bottom: 100.0),
                children: [
                  AppBarProduct(
                      nameProduct: widget.product.nameProduct,
                      uidProduct: widget.product.uidProduct.toString(),
                      isFavorite: widget.product.isFavorite),
                  const SizedBox(height: 20.0),
                  CoverProduct(
                      uidProduct: widget.product.uidProduct.toString(),
                      imageProduct: widget.product.picture),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      children: [
                        TextFrave(
                            text: widget.product.nameProduct,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  RatingProduct(),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      child: Row(
                        children: const [
                          TextFrave(
                              text: 'Disponibilité ',
                              fontSize: 18,
                              color: Colors.green),
                          TextFrave(
                            text: 'En Stock',
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: const TextFrave(
                        text: 'Description',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      children: [
                        TextFrave(
                            text: widget.product.description, fontSize: 17)
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                 
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200]!,
                        blurRadius: 15,
                        spreadRadius: 15)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: size.width * .45,
                        child: TextFrave(
                            text: '${widget.product.price} TND',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(width: 15.0),
                      Container(
                        height: 55,
                        width: size.width * .45,
                        decoration: BoxDecoration(
                            color: ColorsFrave.primaryColorFrave,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0))),
                          child: const TextFrave(
                              text: 'Ajouter au panier',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          onPressed: () {
                            final productSelect = ProductCart(
                                uidProduct:
                                    widget.product.uidProduct.toString(),
                                image: widget.product.picture,
                                name: widget.product.nameProduct,
                                price: widget.product.price.toDouble(),
                                amount: 1);

                            productBloc
                                .add(OnAddProductToCartEvent(productSelect));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
