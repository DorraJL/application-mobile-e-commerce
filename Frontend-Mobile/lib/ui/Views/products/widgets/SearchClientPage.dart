import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commers/Bloc/Product/product_bloc.dart';
import 'package:e_commers/Service/ProductController.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/products/details_product_page.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class SearchClientPage extends StatefulWidget {
  @override
  _SearchClientPageState createState() => _SearchClientPageState();
}

class _SearchClientPageState extends State<SearchClientPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => ProductBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushReplacement(
                            context, routeFrave(page: HomePage())),
                        child: Container(
                          height: 44,
                          child: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8.0)),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                              BlocProvider.of<ProductBloc>(context)
                                  .add(OnSearchProductEvent(value));
                              if (value.length != 0)
                                productServices.searchProductsForName(value);
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Rechercher Produits',
                                hintStyle: GoogleFonts.getFont('Inter',
                                    color: Colors.grey)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (_, state) => Expanded(
                        child: (state.searchProduct.length != 0)
                            ? listProducts()
                            : _HistorySearch()),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationFrave(index: 4),
        );
      }),
    );
  }

  Widget listProducts() {
    return StreamBuilder<List<ListProducts>>(
        stream: productServices.searchProducts,
        builder: (context, snapshot) {
          if (snapshot.data == null) return _HistorySearch();

          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          if (snapshot.data!.length == 0) {
            return ListTile(
              title: TextFrave(
                  text: 'Sans resultat pour ${_searchController.text}'),
            );
          }

          final listProduct = snapshot.data!;

          return _ListProductSearch(listProduct: listProduct);
        });
  }
}

class _ListProductSearch extends StatelessWidget {
  final List<ListProducts> listProduct;

  const _ListProductSearch({required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    routeFrave(
                        page: DetailsProductPage(product: listProduct[i]))),
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                scale: 8,
                                image: NetworkImage(
                                    URLS.baseUrl + listProduct[i].picture))),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFrave(text: listProduct[i].nameProduct),
                            SizedBox(height: 5.0),
                            TextFrave(
                                text: ' ${listProduct[i].price}',
                                color: Colors.grey),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _HistorySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFrave(text: 'RECHERCHE RÉCENTE', fontSize: 16, color: Colors.grey),
        SizedBox(height: 10.0),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          minLeadingWidth: 20,
          leading: Icon(Icons.history),
          title: TextFrave(text: '', color: Colors.grey),
        )
      ],
    );
  }
}
