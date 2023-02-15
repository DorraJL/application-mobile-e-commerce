// import 'dart:io';
import 'package:e_commers/Bloc/General/general_bloc.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/Views/Profile/ChangePasswordPage.dart';
import 'package:e_commers/ui/Views/Profile/information_page.dart';
import 'package:e_commers/ui/Views/Profile/shopping/shopping_page.dart';
import 'package:e_commers/ui/Views/Profile/widgets/ListAddressesPage.dart';
import 'package:e_commers/ui/Views/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Profile/widgets/card_item_profile.dart';
import 'package:e_commers/ui/Views/Profile/widgets/divider_line.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import '../../../Bloc/Auth/auth_bloc.dart';
import '../../widgets/AnimationRoute.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              'Picture Change Successfully',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: ProfilePage())));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Stack(
          children: [
            ListProfile(),
            Positioned(
              bottom: 20,
              child: Container(
                  width: size.width,
                  child: Align(child: BottomNavigationFrave(index: 5))),
            ),
          ],
        ),
      ),
    );
  }
}

class ListProfile extends StatefulWidget {
  @override
  _ListProfileState createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  late ScrollController _scrollController;
  double scrollPrevious = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(addListenerScroll);

    super.initState();
  }

  void addListenerScroll() {
    if (_scrollController.offset > scrollPrevious) {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: false));
    } else {
      BlocProvider.of<GeneralBloc>(context)
          .add(OnShowOrHideMenuEvent(showMenu: true));
    }
    scrollPrevious = _scrollController.offset;
  }

  @override
  void dispose() {
    _scrollController.removeListener(addListenerScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(top: 35.0, bottom: 20.0),
      children: [
        BlocBuilder<UserBloc, UserState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => state.user != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Column(
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
                      ],
                    ))
                : const ShimmerFrave()),
        const SizedBox(height: 25.0),
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            children: [
              CardItemProfile(
                text: 'Informations personelle',
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.person_outline_rounded,
                backgroundColor: Color(0xff7882ff),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: EditProfilePage())),
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Ajouter adresses',
                icon: Icons.my_location_rounded,
                backgroundColor: Color(0xffFB5019),
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ListAddressesPage())),
                borderRadius: BorderRadius.circular(50.0),
              ),
              DividerLine(size: size),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: const TextFrave(
            text: 'General',
            fontSize: 17,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 243,
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
          child: Column(
            children: [
              DividerLine(size: size),
              CardItemProfile(
                text: 'Notifications',
                borderRadius: BorderRadius.zero,
                backgroundColor: Color(0xffE87092),
                icon: Icons.notifications_none_rounded,
                onPressed: () {},
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Favories',
                backgroundColor: Color(0xfff28072),
                icon: Icons.favorite_border_rounded,
                borderRadius: BorderRadius.zero,
                onPressed: () =>
                    Navigator.push(context, routeSlide(page: FavoritePage())),
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Mes Ordres',
                backgroundColor: Color(0xff0716A5),
                icon: Icons.shopping_bag_outlined,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30.0)),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: ClientOrdersPage())),
              ),
              CardItemProfile(
                text: 'Changer mot de passe',
                icon: Icons.lock_rounded,
                backgroundColor: Color(0xff1B83F5),
                onPressed: () => Navigator.push(
                    context, routeFrave(page: ChangePasswordPage())),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        const SizedBox(height: 10.0),
        SizedBox(height: 25.0),
        CardItemProfile(
            text: 'Déconnexion',
            borderRadius: BorderRadius.circular(50.0),
            icon: Icons.power_settings_new_sharp,
            backgroundColor: Colors.red,
            onPressed: () {
              authBloc.add(LogOutEvent());
              Navigator.pushAndRemoveUntil(
                  context, routeFrave(page: LoadingPage()), (route) => false);
            }),
      ],
    );
  }
}
