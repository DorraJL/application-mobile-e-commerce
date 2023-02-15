import 'dart:math';

import 'package:e_commers/ui/Views/admin/add_product_page.dart';
import 'package:e_commers/ui/Views/admin/AddUser.dart';
import 'package:e_commers/ui/Views/admin/drawer.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc/Auth/auth_bloc.dart';
import '../../../Bloc/user/user_bloc.dart';
import '../../../Helpers/helpers.dart';
import '../../../Service/urls.dart';
import '../../../Models/Response/response_user.dart';
import '../../../Service/UserController.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class ListMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Constants.mainColor;
    Color secColor = Constants.secTextColor;
    Color textColor = Constants.textColor;
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
                'success',
                () => Navigator.pushReplacement(
                    context, routeFrave(page: ListMenu())));
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Utilisateurs',
              style: TextStyle(color: textColor),
            ),
            iconTheme: IconThemeData(color: mainColor),
            backgroundColor: secColor,
            centerTitle: true,
          ),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new AddUser()));
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromRGBO(255, 82, 48, 1),
          ),
          body: FutureBuilder<List<ListUsers>>(
              future: userServices.getListUsers(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors
                              .accents[Random().nextInt(Colors.accents.length)],
                          radius: 22.0,
                          child: Text(
                            _getTitle(snapshot.data![i].firstName),
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(snapshot.data![i].firstName,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        subtitle: Text(snapshot.data![i].rolId),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                    Icon(Icons.edit, color: Colors.blue[800])),
                            IconButton(
                                onPressed: () => 
                                
                                 modalDeleteUser(
                                      context,
                                      snapshot.data![i].firstName,
                                      snapshot.data![i].uid.toString(),
                                    ),
                                icon: Icon(Icons.delete),
                                color: Colors.red),
                          ],
                        ),
                      );
                    });
              }),
        ));
  }

  String _getTitle(String first_name) {
    return first_name.substring(0, 1);
  }
}
