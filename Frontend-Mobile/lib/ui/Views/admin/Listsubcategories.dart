import 'package:e_commers/Models/Response/subcategoriesofcategories.dart';
import 'package:e_commers/ui/Views/admin/editsubcategory.dart';
import 'package:flutter/material.dart';
import '../../../Helpers/helpers.dart';
import '../../../Service/ProductController.dart';
import '../../themes/colors_tech4iot.dart';
import '../../widgets/AnimationRoute.dart';
import '../../widgets/widgets.dart';
import 'package:e_commers/ui/Views/admin/AddSubCategoryAdminPage.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class Subcategoriespage extends StatefulWidget {
  final int uidCategory;

  Subcategoriespage({required this.uidCategory});

  @override
  State<Subcategoriespage> createState() => _SubcategoriespageState();
}

class _SubcategoriespageState extends State<Subcategoriespage> {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFrave(text: 'Sous Categorie'),
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
                color: ColorsFrave.primaryColorFrave,
              )
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, routeFrave(page: AddSubCategoryAdminPage())),
              child: TextFrave(
                  text: 'Ajouter',
                  color: ColorsFrave.primaryColorFrave,
                  fontSize: 17))
        ],
      ),
      body: FutureBuilder<List<Categoriess>>(
          future: productServices
              .getsubcategoryForCategories(widget.uidCategory.toString()),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, i) => ListTile(
                      title: Text(snapshot.data![i].category),
                      leading: CircleAvatar(
                          backgroundColor: ColorsFrave.secundaryColorFrave,
                          radius: 23.0,
                          child: Text(getTitle(snapshot.data![i].category),
                              style: TextStyle(color: Colors.white))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  routeSlide(
                                      page: EditSubCategorypage(
                                          cat: snapshot.data![i]))),
                              icon: Icon(Icons.edit),
                              color: Colors.blue[800]),
                          IconButton(
                              onPressed: () => modalDeleteSubCtegory(context,
                                  snapshot.data![i].uidCategory.toString()),
                              icon: Icon(Icons.delete),
                              color: Colors.red),
                        ],
                      ),
                    ));
          }),
    );
  }

  String getTitle(String title) {
    var result = "";
    return result = title.substring(0, 2);
  }
}
