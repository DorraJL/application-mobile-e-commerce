import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:e_commers/Helpers/secure_storage_frave.dart';
import 'package:e_commers/Models/Response/response_categories_home.dart';
import 'package:e_commers/Models/Response/subcategoriesofcategories.dart';
import 'package:e_commers/Models/Response/response_default.dart';
import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/Models/Response/response_slide_products.dart';
import 'package:e_commers/Service/urls.dart';
import 'package:e_commers/Helpers/DeBouncer.dart';

import '../Models/Response/response_categories.dart';

class ProductServices {
  final debouncer = DeBouncer(duration: Duration(milliseconds: 800));
  final StreamController<List<ListProducts>> _streamController =
      StreamController<List<ListProducts>>.broadcast();
  Stream<List<ListProducts>> get searchProducts => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  void searchProductsForName(String productName) async {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final token = await secureStorage.readToken();

      final response = await http.get(
          Uri.parse(
              '${URLS.urlApi}/product/search-product-for-name/' + productName),
          headers: {'Accept': 'application/json', 'xxx-token': token!});
      print(jsonDecode(response.body));
      final listProduct =
          ResponseProductsHome.fromJson(jsonDecode(response.body)).listProducts;

      this._streamController.add(listProduct);
    };

    final timer =
        Timer(Duration(milliseconds: 200), () => debouncer.value = productName);
    Future.delayed(Duration(milliseconds: 400)).then((_) => timer.cancel());
  }

  Future<ResponseDefault> editCategory(
      String category, String idcategory) async {
    final token = await secureStorage.readToken();

    final response = await http.put(
        Uri.parse('${URLS.urlApi}/category/edit-category'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'idCategorie': idcategory, 'nomCategorie': category});
    print(jsonDecode(response.body));
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseDefault> editSubCategory(
      String uidsubcategory, String category) async {
    final token = await secureStorage.readToken();

    final response = await http
        .put(Uri.parse('${URLS.urlApi}/category/edit-sub-category'), headers: {
      'Accept': 'application/json',
      'xxx-token': token!
    }, body: {
      'idSousCategorie': uidsubcategory,
      'nomSousCategorie': category,
    });
    print(jsonDecode(response.body));
    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<List<SlideProduct>> listProductsHomeCarousel() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-home-products-carousel'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseSlideProducts.fromJson(jsonDecode(resp.body)).slideProducts;
  }

  Future<List<Categorie>> listCategoriesHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategorieHome.fromJson(jsonDecode(resp.body)).categorie;
  }

  Future<List<ListProducts>> listProductsHome() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/product/get-products-home'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<ResponseDefault> addOrDeleteProductFavorite(String uidProduct) async {
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${URLS.urlApi}/product/like-or-unlike-product'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'idProduit': uidProduct});
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<List<Categories>> getAllCategories() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${URLS.urlApi}/category/get-all-sub-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseCategoriesHome.fromJson(jsonDecode(resp.body)).categories;
  }

  Future<List<ListProducts>> allFavoriteProducts() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-all-favorite'),
      headers: {'Accept': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<List<ListProducts>> getProductsForCategories(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse('${URLS.urlApi}/product/get-products-for-category/' + id),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );

    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<List<ListProducts>> getProductsByPrice(String min, String max) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse(
            '${URLS.urlApi}/product/get-products-price/' + min + '/' + max),
        headers: {'Content-type': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return ResponseProductsHome.fromJson(jsonDecode(resp.body)).listProducts;
  }

  Future<List<Categoriess>> getsubcategoryForCategories(String id) async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
      Uri.parse(
          '${URLS.urlApi}/category/get-sub-categories-for-category/' + id),
      headers: {'Content-type': 'application/json', 'xxx-token': token!},
    );
    print(jsonDecode(resp.body));
    return ResponseCategories.fromJson(jsonDecode(resp.body)).categories;
  }

  Future<ResponseDefault> updateProduct(
       String name, String description,
      String stock, String price, String uidCategory,String uidsousCategory,String color, String image,
      String uidProduct) async {
    final token = await secureStorage.readToken();
    var request = http.MultipartRequest(
        'PUT', Uri.parse('${URLS.urlApi}/product/update-product'))
     ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['stock'] = stock
      ..fields['price'] = price
      ..fields['uidCategory'] = uidCategory
       ..fields['souscategorie_id'] = uidsousCategory
        ..fields['uidsousCategory'] = color
         ..fields['idProduit'] = uidProduct
      ..files.add(await http.MultipartFile.fromPath('productImage', image));
    final resp = await request.send();
    var data = await http.Response.fromStream(resp);
    print(jsonDecode(data.body));
    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  Future<ResponseDefault> deleteProduct(String uidProduct) async {
    final token = await secureStorage.readToken();

    final resp = await http.delete(
        Uri.parse('${URLS.urlApi}/product/delete-product/' + uidProduct),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(jsonDecode(resp.body));
    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> deleteCategory(String uidCategory) async {
    final token = await secureStorage.readToken();

    final resp = await http.delete(
        Uri.parse('${URLS.urlApi}/category/delete-category/' + uidCategory),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseDefault> deleteSubCategory(String uidCategory) async {
    final token = await secureStorage.readToken();

    final resp = await http.delete(
        Uri.parse('${URLS.urlApi}/category/delete-sub-category/' + uidCategory),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseDefault.fromJson(jsonDecode(resp.body));
  }



  Future<ResponseDefault> addNewProduct(String name, String description,
      String stock, String price, String uidCategory,String uidsousCategory,String color, String image) async {
    final token = await secureStorage.readToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse('${URLS.urlApi}/product/add-new-product'))
      ..headers['Accept'] = 'application/json'
      ..headers['xxx-token'] = token!
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['stock'] = stock
      ..fields['price'] = price
      ..fields['uidCategory'] = uidCategory
       ..fields['uidsousCategory'] = uidsousCategory
        ..fields['color'] = color
      ..files.add(await http.MultipartFile.fromPath('productImage', image)
      );

    final resp = await request.send();
    var data = await http.Response.fromStream(resp);

    return ResponseDefault.fromJson(jsonDecode(data.body));
  }

  

  Future<ResponseDefault> addNewSubCategory(
      String nameCategory, String uidCategory) async {
    final token = await secureStorage.readToken();

    final response = await http.post(
        Uri.parse('${URLS.urlApi}/category/add-sub-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'nomSousCategorie': nameCategory, 'categorie_id': uidCategory});

    return ResponseDefault.fromJson(jsonDecode(response.body));
  }

  Future<ResponseDefault> addNewCategory(String nameCategory) async {
    final token = await secureStorage.readToken();

    final response = await http.post(
        Uri.parse('${URLS.urlApi}/category/add-categories'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'nomCategorie': nameCategory});

    return ResponseDefault.fromJson(jsonDecode(response.body));
  }
}

final productServices = ProductServices();
