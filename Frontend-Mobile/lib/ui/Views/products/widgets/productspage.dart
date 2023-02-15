import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Service/ProductController.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/Views/products/details_product_page.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/staggered_dual_view.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  final int min;
  final int max;

  const ProductsPage({required this.min, required this.max});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

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
        }
      },
      child: Scaffold(
          backgroundColor: Color(0xfff5f5f5),
          appBar: AppBar(
            title: TextFrave(
                text: 'Produits',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              splashRadius: 20,
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: FutureBuilder<List<ListProducts>>(
              future: productServices.getProductsByPrice(
                  widget.min.toString(), widget.max.toString()),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: EdgeInsets.all(10.0),
                        child: StaggeredDualView(
                            itemCount: snapshot.data!.length,
                            spacing: 5,
                            alturaElement: 0.15,
                            aspectRatio: 0.8,
                            itemBuilder: (context, i) => Card(
                                  shadowColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 10.0,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    splashColor: Colors.blue[300],
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => DetailsProductPage(
                                                product: snapshot.data![i]))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Stack(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Hero(
                                                    tag: snapshot
                                                        .data![i].uidProduct
                                                        .toString(),
                                                    child: Image.network(
                                                        URLS.baseUrl +
                                                            snapshot.data![i]
                                                                .picture,
                                                        height: 120)),
                                              ),
                                              const SizedBox(height: 10.0),
                                              TextFrave(
                                                  text: snapshot
                                                      .data![i].nameProduct,
                                                  fontWeight: FontWeight.w500),
                                              TextFrave(
                                                  text:
                                                      '${snapshot.data![i].price} TND',
                                                  fontSize: 16),
                                            ],
                                          ),
                                          Positioned(
                                              right: 0,
                                              child: snapshot.data![i]
                                                          .isFavorite ==
                                                      1
                                                  ? InkWell(
                                                      onTap: () => productBloc.add(
                                                          OnAddOrDeleteProductFavoriteEvent(
                                                              uidProduct: snapshot
                                                                  .data![i]
                                                                  .uidProduct
                                                                  .toString())),
                                                      child: const Icon(
                                                          Icons
                                                              .favorite_rounded,
                                                          color: Colors.red),
                                                    )
                                                  : InkWell(
                                                      onTap: () => productBloc.add(
                                                          OnAddOrDeleteProductFavoriteEvent(
                                                              uidProduct: snapshot
                                                                  .data![i]
                                                                  .uidProduct
                                                                  .toString())),
                                                      child: Icon(Icons
                                                          .favorite_outline_rounded))),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      );
              })),
    );
  }
}
