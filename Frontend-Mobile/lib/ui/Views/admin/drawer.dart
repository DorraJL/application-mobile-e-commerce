import 'package:e_commers/ui/Views/admin/MenuUser.dart';
import 'package:e_commers/ui/Views/admin/dashboard.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/Views/admin/CategoriesAdminPage.dart';
import 'package:e_commers/ui/Views/admin/ListMenu.dart';
import 'package:e_commers/ui/Views/admin/OrdersAdminPage.dart';

import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/ui/Views/admin/MenuProduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commers/ui/themes/constants.dart' as Constants;

import '../../widgets/AnimationRoute.dart';
import '../../widgets/widgets.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    readCreds().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<dynamic> readCreds() async {}

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          BlocBuilder<UserBloc, UserState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) => state.user != null
                  ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BounceInRight(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: TextFrave(
                                        text: state.user!.firstName!,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w500)),
                              ),
                              FadeInRight(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: TextFrave(
                                        text: state.user!.email!,
                                        fontSize: 18,
                                        color: Colors.grey)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const ShimmerFrave()),
          ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                ]),
            title: Text("Tableau de bord"),
            onTap: () => Navigator.push(context, routeFrave(page: MenuUser())),
          ),
          ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.people),
                ]),
            title: Text("utilisateurs"),
            onTap: () => Navigator.push(context, routeFrave(page: ListMenu())),
          ),
          ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.devices_other),
                ]),
            title: Text("produits"),
            onTap: () =>
                Navigator.push(context, routeFrave(page: MenuProduct())),
          ),
          ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.category),
                ]),
            title: Text("categories"),
            onTap: () => Navigator.push(
                context, routeFrave(page: CategoriesAdminPage())),
          ),
          ListTile(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.receipt),
                ]),
            title: Text("Ordres"),
            onTap: () =>
                Navigator.push(context, routeFrave(page: OrdersAdminPage())),
          ),
          ListTile(
              leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                  ]),
              title: Text("Déconnexion"),
              onTap: () {
                authBloc.add(LogOutEvent());
                Navigator.pushAndRemoveUntil(
                    context, routeFrave(page: LoadingPage()), (route) => false);
              })
        ],
      ),
    );
  }
}
