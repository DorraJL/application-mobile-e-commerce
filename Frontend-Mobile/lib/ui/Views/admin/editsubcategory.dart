import 'dart:io';

import 'package:e_commers/Models/Response/response_products_home.dart';
import 'package:e_commers/ui/Views/admin/Listsubcategories.dart';
import 'package:e_commers/ui/Views/admin/MenuProduct.dart';
import 'package:e_commers/ui/Views/admin/MenuUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Bloc/Product/product_bloc.dart';
import '../../../Bloc/category/category_bloc.dart';
import '../../../Helpers/helpers.dart';
import '../../../Models/Response/response_categories_home.dart';
import '../../../Models/Response/subcategoriesofcategories.dart';
import '../../themes/colors_tech4iot.dart';
import '../../widgets/widgets.dart';
import '../../../Service/urls.dart';

class EditSubCategorypage extends StatefulWidget {
  final Categoriess cat;

  EditSubCategorypage({required this.cat});

  @override
  _EditSubCategorypageState createState() => _EditSubCategorypageState();
}

class _EditSubCategorypageState extends State<EditSubCategorypage> {
  late TextEditingController _namecatController;

  final _keyForm = GlobalKey<FormState>();
  Future<void> getProductInformation() async {
    _namecatController = TextEditingController(text: widget.cat.category);
  }

  @override
  void initState() {
    super.initState();
    getProductInformation();
  }

  @override
  void dispose() {
    _namecatController.clear();
    _namecatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is LoadingCategoryState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureCategoryState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessCategoryState) {
          Navigator.pop(context);
          modalSuccess(context, 'sous categorie mdifié!', onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                routeSlide(
                    page:
                        Subcategoriespage(uidCategory: widget.cat.idCategory)),
                (_) => false);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const TextFrave(
              text: 'Modifier Categorie', fontSize: 20, fontWeight: FontWeight.bold),
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
                    BlocProvider.of<CategoryBloc>(context).add(
                        OnEditSubCategoryEvent(
                            widget.cat.uidCategory.toString(),
                            _namecatController.text.trim()));
                  }
                },
                child: const TextFrave(
                    text: 'Enregistrer',
                    color: ColorsFrave.primaryColorFrave,
                    fontWeight: FontWeight.w500))
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              children: [
                TextFrave(
                    text: 'Categorie', color: ColorsFrave.secundaryColorFrave),
                SizedBox(height: 5.0),
                FormFieldFrave(
                    controller: _namecatController,
                    validator:
                        RequiredValidator(errorText: 'champs obligatoire')),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
