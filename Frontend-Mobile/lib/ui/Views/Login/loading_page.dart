import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Delivery/DeliveryHomePage.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/Views/admin/ListMenu.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../admin/MenuUser.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);

    _animation.addStatusListener(_animationListener);

    _animationController.forward();
  }

  _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeStatusListener(_animationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthState) {
          Navigator.pushReplacement(context, routeSlide(page: LoadingPage()));
        } else if (state is LogOutAuthState) {
          Navigator.of(context)
              .pushAndRemoveUntil(routeFade(page: SignInPage()), (_) => false);
        } else if (state.rolId != '') {
          userBloc.add(OnGetUserEvent());

          if (state.user!.rolId == 'admin' || state.user!.rolId == 'Supadmin'){
            Navigator.of(context)
                .pushAndRemoveUntil(routeFade(page: MenuUser()), (_) => false);
          } else if (state.rolId == 'client') {
            Navigator.of(context)
                .pushAndRemoveUntil(routeFade(page: HomePage()), (_) => false);
          } else if (state.rolId == 'livreur') {
            Navigator.of(context).pushAndRemoveUntil(
                routeFade(page: DeliveryHomePage()), (_) => false);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff1E4DD8),
        body: Center(
            child: SizedBox(
          height: 212,
          width: 181,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) => Transform.scale(
                  scale: _animation.value,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
              const SizedBox(height: 10.0),
              const TextFrave(
                  text: 'Verification...', color: Colors.white60)
            ],
          ),
        )),
      ),
    );
  }
}
