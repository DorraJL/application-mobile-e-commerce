import 'package:e_commers/Bloc/Auth/auth_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/validation_form.dart';
import 'package:e_commers/ui/Views/Delivery/DeliveryHomePage.dart';
import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/Views/Login/ForgotPasswordPage.dart';
import 'package:e_commers/ui/Views/admin/MenuUser.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/Password/general_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passowrdController;
  final _keyForm = GlobalKey<FormState>();
  bool isChangeSuffixIcon = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passowrdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    _passowrdController.clear();
    _passowrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final generalBloc = BlocProvider.of<PasswordBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LoadingAuthState) {
          modalLoading(context, 'Validating...');
        } else if (state is FailureAuthState) {
          Navigator.of(context).pop();
          errorMessageSnack(context, state.error);
          print(state.error);
        } else {
          userBloc.add(OnGetUserEvent());
          Navigator.pop(context);

          if (state.user!.rolId == 'admin' || state.user!.rolId == 'Supadmin') {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: MenuUser()), (route) => false);
          } else if (state.user!.rolId == 'admin') {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: MenuUser()), (route) => false);
          } else if (state.user!.rolId == 'client') {
            Navigator.pushAndRemoveUntil(
                context, routeSlide(page: HomePage()), (route) => false);
          } else if (state.user!.rolId == 'livreur') {
            Navigator.pushAndRemoveUntil(context,
                routeSlide(page: DeliveryHomePage()), (route) => false);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.close_rounded, size: 25, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              child: TextFrave(
                text: 'Registre',
                fontSize: 18,
                color: ColorsFrave.primaryColorFrave,
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('signUpPage'),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Column(children: [
                    const TextFrave(
                        text: 'Bienvenue',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: ColorsFrave.primaryColorFrave),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        const TextFrave(
                            text: '   Reconnectez-vous à votre compte ',
                            fontSize: 15),
                        TextFrave(
                            text: 'TECH4IOT',
                            color: ColorsFrave.primaryColorFrave,
                            fontWeight: FontWeight.w700),
                        TextFrave(
                          text: 'STORE.',
                          fontWeight: FontWeight.w700,
                          color: ColorsFrave.secundaryColorFrave,
                        ),
                      ],
                    )
                  ]),
                ),
                const SizedBox(height: 35),
                TextFormFrave(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validatedEmail,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                ),
                const SizedBox(height: 20),
                BlocBuilder<PasswordBloc, GeneralState>(
                    builder: (context, state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormFrave(
                                controller: _passowrdController,
                                isPassword: state.isShowPassword,
                                hintText: 'Mot de passe',
                                prefixIcon: Icon(Icons.password_rounded),
                                suffixIcon: IconButton(
                                    splashRadius: 20,
                                    icon: state.isShowPassword
                                        ? Icon(Icons.visibility_off_rounded)
                                        : Icon(Icons.remove_red_eye_outlined),
                                    onPressed: () {
                                      bool isShowPassword =
                                          !generalBloc.state.isShowPassword;
                                      generalBloc.add(OnShowOrHidePasswordEvent(
                                          isShowPassword));
                                    }),
                                validator: passwordValidator,
                              ),
                            ])),
                const SizedBox(height: 60),
                BtnFrave(
                  text: 'Se connecter',
                  backgroundColor: ColorsFrave.secundaryColorFrave,
                  width: size.width,
                  fontSize: 20,
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      authBloc.add(LoginEvent(
                          _emailController.text, _passowrdController.text));
                    }
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                      child: TextFrave(
                          text: 'Mot de passe oublié?',
                          color: ColorsFrave.secundaryColorFrave,
                          fontSize: 17),
                      onPressed: () => Navigator.push(
                          context, routeSlide(page: ForgotPasswordPage()))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
