import 'package:bloc/bloc.dart';
import 'package:e_commers/Models/product.dart';

import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

import '../../Service/ProductController.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductCart> product = [];

  ProductBloc() : super(ProductInitial()) {
    on<OnAddOrDeleteProductFavoriteEvent>(_addOrDeleteProductFavorite);
    on<OnAddProductToCartEvent>(_addProductToCart);
    on<OnDeleteProductToCartEvent>(_deleteProductCart);
    on<OnPlusQuantityProductEvent>(_plusQuantityProduct);
    on<OnSubtractQuantityProductEvent>(_subtractQuantityProduct);
    on<OnClearProductsEvent>(_clearProduct);
    on<OnSelectPathImageProductEvent>(_selectImageForProduct);
    on<OnSaveNewProductEvent>(_addNewProduct);
    on<OnSearchProductEvent>(_onSearchProductEvent);
    // on<OnUpdateStatusProductEvent>(_onUpdateStatusProduct);
    on<OnDeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _addOrDeleteProductFavorite(
      OnAddOrDeleteProductFavoriteEvent event,
      Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data =
          await productServices.addOrDeleteProductFavorite(event.uidProduct);

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _addProductToCart(
      OnAddProductToCartEvent event, Emitter<ProductState> emit) async {
    final hasProduct = product.contains(event.product);

    if (!hasProduct) {
      product.add(event.product);

      double sum = 0;

      product.forEach((e) => sum = sum + e.price);

      emit(SetAddProductToCartState(
          products: product, total: sum, amount: product.length));
    }
  }

  Future<void> _deleteProductCart(
      OnDeleteProductToCartEvent event, Emitter<ProductState> emit) async {
    product.removeAt(event.index);

    double sum = 0;
    product.forEach((e) => sum = sum + e.price);

    emit(SetAddProductToCartState(
        products: product, total: sum, amount: product.length));
  }

  Future<void> _plusQuantityProduct(
      OnPlusQuantityProductEvent event, Emitter<ProductState> emit) async {
    product[event.plus].amount++;

    double total = 0;
    product.forEach((e) => total = total + (e.price * e.amount));

    emit(SetAddProductToCartState(
        products: product, total: total, amount: product.length));
  }

  Future<void> _subtractQuantityProduct(
      OnSubtractQuantityProductEvent event, Emitter<ProductState> emit) async {
    product[event.subtract].amount--;

    double total = 0;
    product.forEach((e) => total = total - (e.price * e.amount));

    emit(SetAddProductToCartState(
        products: product, total: total.abs(), amount: product.length));
  }

  Future<void> _clearProduct(
      OnClearProductsEvent event, Emitter<ProductState> emit) async {
    product.clear();
    emit(ProductInitial());
  }


  Future<void> _selectImageForProduct(
      OnSelectPathImageProductEvent event, Emitter<ProductState> emit) async {
    emit(SetImageForProductState(event.image));
  }

  Future<void> _addNewProduct(
      OnSaveNewProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.addNewProduct(
        event.name,
        event.description,
        event.stock,
        event.price,
        event.uidCategory,
        event.uidsousCategory,
        event.color,
        event.image,
      );

      if (data.resp) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState(data.message));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _onSearchProductEvent(
      OnSearchProductEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(searchProduct: event.searchProduct));
  }
/*
  Future<void> _onUpdateStatusProduct(
      OnUpdateStatusProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.updateProduct(
          event.name,
          event.description,
          event.stock,
          event.price,
          event.status,
          event.image,
          event.uidProduct);

      if (data.resp)
        emit(SuccessProductState());
      else
        emit(FailureProductState(data.message));
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }*/

  Future<void> _onDeleteProduct(
      OnDeleteProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data = await productServices.deleteProduct(event.idProduct);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp)
        emit(SuccessProductState());
      else
        emit(FailureProductState(data.message));
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }
}
