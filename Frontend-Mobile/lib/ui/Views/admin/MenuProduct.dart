
import 'package:e_commers/ui/Views/admin/add_product_page.dart';
import 'package:e_commers/ui/Views/admin/drawer.dart';
import 'package:e_commers/ui/Views/admin/editProduct.dart';
import 'package:flutter/material.dart';
import '../../../Models/Response/response_products_home.dart';
import '../../../Service/ProductController.dart';
import '../../../Service/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;


class MenuProduct extends StatefulWidget {
  @override
  State<MenuProduct> createState() => _MenuProductState();
}

class _MenuProductState extends State<MenuProduct> {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
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
        appBar: AppBar(
           title: Text(
              'Produits',
              style: TextStyle(color: textColor),
            ),
            iconTheme: IconThemeData(color: mainColor),
            backgroundColor: secColor,
            centerTitle: true,
          ),
          drawer: MyDrawer(),
      
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new AddProductPage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(255, 82, 48, 1),
        ),
        body: FutureBuilder<List<ListProducts>>(
            future: productServices.listProductsHome(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return _ListProduct(listProducts: snapshot.data!);
            }),
      ),
    );
  }
}

class _ListProduct extends StatelessWidget {
  final List<ListProducts> listProducts;

  const _ListProduct({required this.listProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    URLS.baseUrl + listProducts[i].picture,
                  ),
                ),
              ),
            ),
            title: Text(
              listProducts[i].nameProduct,
            ),
            subtitle: Text(listProducts[i].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        routeSlide(
                            page: EditProductpage(product: listProducts[i]))),
                    icon: Icon(Icons.edit),
                    color: Colors.blue[800]),
                IconButton(
                    onPressed: () => modalDeleteProduct(
                        context,
                        listProducts[i].nameProduct,
                        listProducts[i].picture,
                        listProducts[i].uidProduct.toString()),
                    icon: Icon(Icons.delete),
                    color: Colors.red),
              ],
            ),
          );
        });
  }
}
