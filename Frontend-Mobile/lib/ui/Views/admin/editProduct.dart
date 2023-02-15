import 'dart:io';

import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/ui/Views/admin/MenuProduct.dart';
import 'package:e_commers/ui/Views/admin/MenuUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commers/Bloc/category/category_bloc.dart';
import 'package:e_commers/Bloc/product/product_bloc.dart';
import '../../../Helpers/helpers.dart';
import '../../themes/colors_tech4iot.dart';
import '../../widgets/widgets.dart';
import '../../../Service/urls.dart';

class EditProductpage extends StatefulWidget {
  final ListProducts product;

  EditProductpage({required this.product});

  @override
  _EditProductpageState createState() => _EditProductpageState();
}

class _EditProductpageState extends State<EditProductpage> {
  late TextEditingController _nameProductController;
  late TextEditingController _descriptionProductController;
  late TextEditingController _stockController;
  late TextEditingController _priceController;
  late TextEditingController _statusController;

  final _keyForm = GlobalKey<FormState>();
  Future<void> getProductInformation() async {
    _nameProductController =
        TextEditingController(text: widget.product.nameProduct);
    _descriptionProductController =
        TextEditingController(text: widget.product.description);
    _stockController =
        TextEditingController(text: widget.product.stock.toString());
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _statusController = TextEditingController(text: widget.product.status);
  }

  @override
  void initState() {
    super.initState();
    getProductInformation();
  }

  @override
  void dispose() {
    _nameProductController.clear();
    _nameProductController.dispose();
    _descriptionProductController.clear();
    _descriptionProductController.dispose();
    _stockController.clear();
    _stockController.dispose();
    _priceController.clear();
    _priceController.dispose();
    _statusController.clear();
    _statusController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bool _value = false;
    final size = MediaQuery.of(context).size;
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadingProductState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureProductState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessProductState) {
          Navigator.pop(context);
          modalSuccess(context, 'Produit modifié!', onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: MenuProduct()), (_) => false);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(
              text: 'Modifier Produit', fontSize: 20, fontWeight: FontWeight.bold),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    productBloc.add(OnUpdateStatusProductEvent(
                      _nameProductController.text.trim(),
                      _descriptionProductController.text.trim(),
                      _stockController.text.trim(),
                      _priceController.text.trim(),
                      _statusController.text.trim(),
                      widget.product.uidProduct.toString(),
                      productBloc.state.pathImage!,
                    ));
                  }
                },
                child: const TextFrave(
                    text: 'Enregistrer',
                    color: ColorsFrave.primaryColorFrave,
                    fontWeight: FontWeight.w500))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            children: [
              InkWell(
                onTap: () => modalSelectPicture(
                  context: context,
                  onPressedImage: () async {
                    Navigator.pop(context);
                    AccessPermission()
                        .permissionAccessGalleryOrCameraForProduct(
                            await Permission.storage.request(),
                            context,
                            ImageSource.gallery);
                  },
                  onPressedPhoto: () async {
                    Navigator.pop(context);
                    AccessPermission()
                        .permissionAccessGalleryOrCameraForProduct(
                            await Permission.camera.request(),
                            context,
                            ImageSource.camera);
                  },
                ),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (_, state) => state.pathImage != null
                      ? Container(
                          height: 190,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(state.pathImage!)))),
                        )
                      : Container(
                          height: 190,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      URLS.baseUrl + widget.product.picture))),
                        ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFrave(text: 'Nom', color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              FormFieldFrave(
                  controller: _nameProductController,
                  validator: RequiredValidator(errorText: 'champs obligatoire')),
              const SizedBox(height: 20.0),
              TextFrave(
                  text: 'Description', color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              FormFieldFrave(
                  controller: _descriptionProductController,
                  validator:
                      RequiredValidator(errorText: 'champs obligatoire')),
              const SizedBox(height: 20.0),
              TextFrave(text: 'Stock', color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _stockController,
                keyboardType: TextInputType.number,
                validator:
                    RequiredValidator(errorText: 'champs obligatoire'),
              ),
              const SizedBox(height: 20.0),
              TextFrave(text: 'Prix', color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              FormFieldFrave(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator:
                      RequiredValidator(errorText: 'champs obligatoire')),
              const SizedBox(height: 20.0),
              TextFrave(text: 'Status ', color: ColorsFrave.primaryColorFrave),
              SizedBox(height: 5.0),
              FormFieldFrave(
                  controller: _statusController,
                  validator:
                      RequiredValidator(errorText: 'champs obligatoire')),
              const SizedBox(height: 20.0),
             
            ],
          ),
        ),
      ),
    );
  }
}
