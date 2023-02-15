
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';


import 'package:e_commers/ui/Views/admin/dashboard.dart';
import 'package:e_commers/ui/Views/admin/drawer.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commers/ui/themes/constants.dart' as Constants;
import '../../../Helpers/helpers.dart';

import '../../widgets/AnimationRoute.dart';


class MenuUser extends StatefulWidget {
  @override
  _MenuUserState createState() => _MenuUserState();
}

class _MenuUserState extends State<MenuUser>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LoadingUserState) {
            modalLoading(context, 'Loading...');
          } else if (state is FailureUserState) {
            Navigator.pop(context);
            errorMessageSnack(context, state.error);
          } else if (state is SuccessAuthState) {
            Navigator.pop(context);
            modalSucces(
                context,
                'Success',
                () => Navigator.pushReplacement(
                    context, routeFrave(page: MenuUser())));
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Tableau de bord',
              style: TextStyle(color: textColor),
            ),
            backgroundColor: secColor,
            iconTheme: IconThemeData(color: mainColor),
            bottom: TabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.dashboard,
                    color: Colors.black54,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.assessment,
                    color: Colors.black54,
                  ),
                  text: 'Status',
                )
              ],
            ),
          ),
          key: _scaffoldkey,
          body: Dashboard(tabController),
          drawer: MyDrawer(),
        ));
  }
}
