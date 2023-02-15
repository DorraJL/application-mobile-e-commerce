import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commers/Bloc/Password/general_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/validation_form.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:e_commers/Helpers/helpers.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    clearTextEditingController();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void clearTextEditingController() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _repeatPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final generalBloc = BlocProvider.of<PasswordBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, 'Checking...');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSucces(
              context, 'Mot de passe changé', () => Navigator.pop(context));
          clearTextEditingController();
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextFrave(text: 'Changer le mot de passe'),
          centerTitle: true,
          leadingWidth: 80,
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: BlocBuilder<PasswordBloc, GeneralState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                      controller: _currentPasswordController,
                      isPassword: state.isShowPassword,
                      hintText: 'mot de passe actuel',
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isShowPassword
                              ? Icon(Icons.visibility_off_rounded)
                              : Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isShowPassword;
                            generalBloc
                                .add(OnShowOrHidePasswordEvent(isShowPassword));
                          }),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                      controller: _newPasswordController,
                      isPassword: state.isNewPassword,
                      hintText: 'Nouveau mot de passe',
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isNewPassword
                              ? Icon(Icons.visibility_off_rounded)
                              : Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isNewPassword;
                            generalBloc.add(
                                OnShowOrHideNewPasswordEvent(isShowPassword));
                          }),
                      validator: passwordValidator,
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(height: 5.0),
                    _FormFieldFravePassword(
                      controller: _repeatPasswordController,
                      isPassword: state.isRepeatpassword,
                      hintText: 'Retapez le nouveau mot de passe',
                      suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isRepeatpassword
                              ? Icon(Icons.visibility_off_rounded)
                              : Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            bool isShowPassword =
                                !generalBloc.state.isRepeatpassword;
                            generalBloc.add(OnShowOrHideRepeatPasswordEvent(
                                isShowPassword));
                          }),
                      validator: (val) {
                        if (val != _newPasswordController.text) {
                          return 'les deux mots de passe ne sont pas identique';
                        } else if (val == '') {
                          return 'veuillez retapez le mot de passe ';
                        }
                      },
                    ),
                    SizedBox(height: 30.0),
                    BtnFrave(
                        text: 'Continuer',
                        width: size.width,
                        fontSize: 20,
                        backgroundColor: ColorsFrave.secundaryColorFrave,
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnChangePasswordEvent(
                                _currentPasswordController.text,
                                _newPasswordController.text));
                          }
                        }),
                    SizedBox(height: 10.0),
                    BtnFrave(
                      text: 'Annuler',
                      width: size.width,
                      fontSize: 20,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FormFieldFravePassword extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final int maxLine;
  final bool readOnly;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;

  const _FormFieldFravePassword(
      {this.controller,
      this.hintText,
      this.isPassword = false,
      this.keyboardType = TextInputType.text,
      this.maxLine = 1,
      this.readOnly = false,
      this.suffixIcon,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.getFont('Roboto', fontSize: 18),
      obscureText: isPassword,
      maxLines: maxLine,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: .5, color: Colors.grey)),
          contentPadding: EdgeInsets.only(left: 15.0),
          hintText: hintText,
          hintStyle: GoogleFonts.getFont('Roboto', color: Colors.grey),
          suffixIcon: suffixIcon),
      validator: validator,
    );
  }
}
