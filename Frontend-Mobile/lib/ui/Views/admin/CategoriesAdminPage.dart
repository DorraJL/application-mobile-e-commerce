import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/admin/Listsubcategories.dart';
import 'package:e_commers/ui/Views/admin/drawer.dart';
import 'package:e_commers/ui/Views/admin/editcategory.dart';
import 'package:flutter/material.dart';
import '../../../Service/ProductController.dart';
import 'package:e_commers/Models/Response/response_categories.dart';
import 'package:e_commers/ui/Views/admin/AddCategoryAdminPage.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class CategoriesAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Catégories',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, routeFrave(page: AddCategoryAdminPage())),
              child: TextFrave(
                  text: 'Ajouter',
                  color: ColorsFrave.primaryColorFrave,
                  fontSize: 17))
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Categorie>>(
          future: productServices.listCategoriesHome(),
          builder: (context, snapshot) => !snapshot.hasData
              ? Center(
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      TextFrave(text: 'Loading Categories...')
                    ],
                  ),
                )
              : _ListCategories(listCategory: snapshot.data!)),
    );
  }
}

class _ListCategories extends StatelessWidget {
  final List<Categorie> listCategory;

  const _ListCategories({required this.listCategory});

  @override
  Widget build(BuildContext context) {
    Color textColor = Constants.textColor;
    return ListView.builder(
        itemCount: listCategory.length,
        itemBuilder: (context, i) => ListTile(
          
              title: TextButton(
                onPressed: () => Navigator.push(
                    context,
                    routeFrave(
                        page: Subcategoriespage(
                            uidCategory: listCategory[i].uidCategory))),
                child: Text(listCategory[i].category,
                    style: TextStyle(color: textColor)),
              ),
              leading: CircleAvatar(
                  backgroundColor: ColorsFrave.secundaryColorFrave,
                  radius: 23.0,
                  child: Text(getTitle(listCategory[i].category),
                      style: TextStyle(color: Colors.white))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          routeSlide(
                              page: EditCategorypage(cat: listCategory[i]))),
                      icon: Icon(Icons.edit),
                      color: Colors.blue[800]),
                  IconButton(
                      onPressed: () => modalDeleteCtegory(
                          context, listCategory[i].uidCategory.toString()),
                      icon: Icon(Icons.delete),
                      color: Colors.red),
                ],
              ),
            ));
  }

  String getTitle(String title) {
    var result = "";
    return result = title.substring(0, 2);
  }
}
