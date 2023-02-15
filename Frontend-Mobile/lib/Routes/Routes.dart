import 'package:e_commers/ui/Views/Delivery/DeliveryHomePage.dart';
import 'package:e_commers/ui/Views/Home/widgets/list_products_home.dart';
import 'package:e_commers/ui/Views/Profile/information_page.dart';
import 'package:e_commers/ui/Views/admin/CategoriesAdminPage.dart';
import 'package:e_commers/ui/Views/admin/ListMenu.dart';
import 'package:e_commers/ui/Views/admin/MenuUser.dart';
import 'package:e_commers/ui/Views/admin/dashboard.dart';
import 'package:e_commers/ui/Views/categories/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/Views/Login/register_page.dart';
import 'package:e_commers/ui/Views/admin/MenuProduct.dart';
import '../ui/Views/Home/home_page.dart';
import '../ui/Views/Profile/profile_page.dart';
import '../ui/Views/cart/cart_page.dart';
import '../ui/Views/favorite/favorite_page.dart';

Map<String, Widget Function(BuildContext context)> routes = {
  'homePage': (context) => HomePage(),
  'loadingPage': (context) => LoadingPage(),
  'signInPage': (context) => SignInPage(),
  'signUpPage': (context) => SignUpPage(),
  'cartPage': (context) => CartPage(),
  'favoritePage': (context) => FavoritePage(),
  'profilePage': (context) => ProfilePage(),
  'InformationPage': (context) => EditProfilePage(),
  'MenuProduct': (context) => MenuProduct(),
  'MenuUser': (context) => MenuUser(),
  'ListMenu': (context) => ListMenu(),
  'listcategories': (context) => CategoriesAdminPage(),
  'categories': (context) => CategoriesPage(),
  'livraison': (context) => DeliveryHomePage(),
};
