
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:e_commers/ui/Views/admin/CategoriesAdminPage.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/Bloc/category/category_bloc.dart';
import '../../widgets/widgets.dart';
import '../../../Helpers/helpers.dart';

class AddCategoryAdminPage extends StatefulWidget {
  @override
  _AddCategoryAdminPageState createState() => _AddCategoryAdminPageState();
}

class _AddCategoryAdminPageState extends State<AddCategoryAdminPage> {
  late TextEditingController _nameCategoryController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _nameCategoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameCategoryController.clear();
    _nameCategoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is LoadingCategoryState) {
          modalLoading(context, 'Checking...');
        } else if (state is FailureCategoryState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessCategoryState) {
          Navigator.pop(context);
          modalSucces(
            context,
            'Produit ajouté avec succès',
            () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: CategoriesAdminPage()), (_) => false),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'Ajouter Categorie'),
          centerTitle: true,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsFrave.primaryColorFrave, size: 17),
                TextFrave(
                    text: 'Retour',
                    fontSize: 17,
                    color: ColorsFrave.primaryColorFrave)
              ],
            ),
          ),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    categoryBloc.add(OnAddNewCategoryEvent(
                      _nameCategoryController.text.trim(),
                    ));
                  }
                },
                child: TextFrave(
                    text: 'Enregistrer', color: ColorsFrave.primaryColorFrave))
          ],
        ),
        body: Form(
          key: _keyForm,
          child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              children: [
                SizedBox(height: 20.0),
                TextFrave(text: 'Nom Categorie'),
                SizedBox(height: 5.0),
                FormFieldFrave(
                  controller: _nameCategoryController,
                  validator:
                      RequiredValidator(errorText: 'Champs obligatoire'),
                ),
              ]),
        ),
      ),
    );
  }
}
