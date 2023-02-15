import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Profile/widgets/card_item_profile.dart';
import 'package:e_commers/ui/widgets/AnimationRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/ui/Views/Delivery/ListOrdersDeliveryPage.dart';
import 'package:e_commers/ui/Views/Delivery/OrderDeliveredPage.dart';
import 'package:e_commers/ui/Views/Delivery/OrderOnWayPage.dart';
import 'package:e_commers/ui/Views/Login/ForgotPasswordPage.dart';
import 'package:e_commers/ui/Views/Profile/information_page.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class DeliveryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          modalLoading(context, 'Loading...');
        } else if (state is SuccessAuthState) {
          Navigator.pop(context);
          modalSucces(
              context,
              'succes',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: DeliveryHomePage())));
          Navigator.pop(context);
        } else if (state is FailureAuthState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              SizedBox(height: 20.0),
              Center(
                  child: TextFrave(
                      text: authBloc.state.user!.firstName! + ' ',
                      fontSize: 25,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 5.0),
              Center(
                  child: TextFrave(
                      text: authBloc.state.user!.email!,
                      fontSize: 20,
                      color: Colors.grey.shade800)),
              SizedBox(height: 70.0),
              TextFrave(text: 'Compte', color: Colors.grey),
              SizedBox(height: 10.0),
              CardItemProfile(
                text: 'Modifier le profil',
                icon: Icons.person,
                onPressed: () => Navigator.push(
                    context, routeFrave(page: EditProfilePage())),
                backgroundColor: Color(0xff7882ff),
                borderRadius: BorderRadius.circular(50.0),
              ),
              CardItemProfile(
                text: 'Changer mot de passe',
                icon: Icons.lock_rounded,
                borderRadius: BorderRadius.circular(50.0),
                backgroundColor: Color(0xff1B83F5),
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ForgotPasswordPage())),
              ),
              SizedBox(height: 15.0),
              TextFrave(text: 'Livraison', color: Colors.grey),
              SizedBox(height: 10.0),
              CardItemProfile(
                text: 'Ordres',
                icon: Icons.checklist_rounded,
                backgroundColor: Color(0xff5E65CD),
                borderRadius: BorderRadius.circular(50.0),
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ListOrdersDeliveryPage())),
              ),
              CardItemProfile(
                text: 'En route',
                icon: Icons.delivery_dining_rounded,
                backgroundColor: Color(0xff1A60C1),
                borderRadius: BorderRadius.circular(50.0),
                onPressed: () =>
                    Navigator.push(context, routeFrave(page: OrderOnWayPage())),
              ),
              CardItemProfile(
                text: 'Livré',
                icon: Icons.check_rounded,
                backgroundColor: Color(0xff4BB17B),
                borderRadius: BorderRadius.circular(50.0),
                onPressed: () => Navigator.push(
                    context, routeFrave(page: OrderDeliveredPage())),
              ),
              SizedBox(height: 15.0),
              Divider(),
              CardItemProfile(
                text: 'Déconnexion',
                icon: Icons.power_settings_new_sharp,
                backgroundColor: Color(0xffF02849),
                borderRadius: BorderRadius.circular(50.0),
                onPressed: () {
                  authBloc.add(LogOutEvent());
                  Navigator.pushAndRemoveUntil(context,
                      routeFrave(page: LoadingPage()), (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
