part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<ProductCart>? products;
  final double total;
  final int amount;
  final double delivery;
  final double insurance;
  final String? pathImage;
  final int idCategory;
  final String? category;
  final List<XFile>? images;
  final String searchProduct;

  ProductState(
      {this.products,
      this.total = 00.0,
      this.amount = 0,
      this.delivery = 15.0,
      this.insurance = 10.0,
       this.pathImage,
      this.idCategory = 0,
      this.category,
      this.images,
      this.searchProduct = ''});

  ProductsState copyWith(
          {int? idCategory,
          String? category,
          List<XFile>? images,
          String? searchProduct}) =>
      ProductsState(
          idCategory: idCategory ?? this.idCategory,
          category: category ?? this.category,
          images: images ?? this.images,
          searchProduct: searchProduct ?? this.searchProduct);
}

class ProductInitial extends ProductState {
  ProductInitial() : super(products: [], total: 00.0, amount: 0);
}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {}

class FailureProductState extends ProductState {
  final String error;

  FailureProductState(this.error);
}

class SetAddProductToCartState extends ProductState {
  final List<ProductCart> products;
  final double total;
  final int amount;

  SetAddProductToCartState(
      {required this.products, required this.total, required this.amount})
      : super(products: products, total: total, amount: amount);
}

class SetImageForProductState extends ProductState {
  final String path;

  SetImageForProductState(this.path) : super(pathImage: path);
}

class ProductsState extends ProductState {
  final int idCategory;
  final String? category;
  final List<XFile>? images;
  final String searchProduct;
  ProductsState(
      {required this.idCategory,
      required this.category,
      required this.images,
      required this.searchProduct})
      : super(
            idCategory: idCategory,
            category: category,
            images: images,
            searchProduct: searchProduct);
}
