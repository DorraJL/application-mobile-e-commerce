import 'package:e_commers/Bloc/Password/general_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Helpers/validation_form.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController _phoneController;
  late TextEditingController passowrdController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = TextEditingController();
    emailController = TextEditingController();
    _phoneController = TextEditingController();
    passowrdController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    userController.dispose();
    emailController.dispose();
    passowrdController.dispose();
    passController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void clear() {
    userController.clear();
    emailController.clear();
    passowrdController.clear();
    passController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;
    final generalBloc = BlocProvider.of<PasswordBloc>(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Validating...');
        }
        if (state is SuccessUserState) {
          Navigator.of(context).pop();
          modalSuccess(context, 'Succès', onPressed: () {
            clear();
            Navigator.pushReplacement(context, routeSlide(page: SignInPage()));
          });
        }
        if (state is FailureUserState) {
          Navigator.of(context).pop();
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            splashRadius: 20,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              child: const TextFrave(
                  text: 'Connectez-vous',
                  fontSize: 17,
                  color: ColorsFrave.primaryColorFrave),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('signInPage'),
            ),
            SizedBox(width: 5)
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: const [
                  TextFrave(
                      text: 'Bienvenue dans ',
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                  TextFrave(
                      text: 'TECH4IOT',
                      fontSize: 20,
                      color: ColorsFrave.primaryColorFrave,
                      fontWeight: FontWeight.w700),
                  TextFrave(
                    text: 'STORE.',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorsFrave.secundaryColorFrave,
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              TextFrave(text: 'Créer votre compte', fontSize: 18),
              SizedBox(height: 20.0),
              TextFormFrave(
                hintText: 'Nom',
                prefixIcon: Icon(Icons.person),
                controller: userController,
                validator:
                    RequiredValidator(errorText: 'Ce champs est obligatoire'),
              ),
              SizedBox(height: 15.0),
              TextFormFrave(
                  hintText: 'Email ',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email_outlined),
                  controller: emailController,
                  validator: validatedEmail),
              SizedBox(height: 15.0),
              TextFormFrave(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  hintText: '00-000-000',
                  prefixIcon: Icon(Icons.phone),
                  validator: validatedPhoneForm),
              SizedBox(height: 15.0),
              BlocBuilder<PasswordBloc, GeneralState>(
                  builder: (context, state) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormFrave(
                              controller: passowrdController,
                              isPassword: state.isShowPassword,
                              hintText: 'Mot de passe',
                              prefixIcon: Icon(Icons.vpn_key_rounded),
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
                            SizedBox(height: 15.0),
                            TextFormFrave(
                                controller: passController,
                                isPassword: state.isShowPassword,
                                hintText: ' Confirmer le mot de passe',
                                prefixIcon: Icon(Icons.vpn_key_rounded),
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
                                validator: (val) => MatchValidator(
                                        errorText:
                                            'Les deux mots de passe saisis ne sont pas identiques! ')
                                    .validateMatch(
                                        val!, passowrdController.text)),
                          ])),
              SizedBox(height: 15.0),
              BtnFrave(
                text: 'Continuer',
                width: size.width,
                fontSize: 20,
                backgroundColor: ColorsFrave.secundaryColorFrave,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    userBloc.add(OnAddNewUserEvent(
                        userController.text.trim(),
                        _phoneController.text.trim(),
                        emailController.text.trim(),
                        passowrdController.text.trim()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
