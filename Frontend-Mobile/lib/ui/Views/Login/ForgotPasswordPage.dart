import 'package:e_commers/ui/Views/Login/CheckEmailPage.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/Helpers/validation_form.dart';
import 'package:e_commers/ui/Views/Login/loading_page.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import '../../widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextFrave(
            text: 'Réinitialiser le mot de passe', fontSize: 21, fontWeight: FontWeight.w500),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pushReplacement(
              context, routeFrave(page: SignInPage())),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: ColorsFrave.primaryColorFrave),
              TextFrave(
                  text: 'Retour',
                  color: ColorsFrave.primaryColorFrave,
                  fontSize: 18)
            ],
          ),
        ),
        actions: [Icon(Icons.help_outline_outlined)],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: [
              TextFrave(
                text:
                    'Entrez l\'e-mail associé à votre compte et bien envoyez un e-mail avec des instructions pour réinitialiser votre mot de passe',
                color: Color(0xff5B6589),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30.0),
              TextFrave(text: 'Email Adresse'),
              SizedBox(height: 5.0),
              FormFieldFrave(
                controller: _emailController,
                hintText: 'example@Tech4iot.com',
                validator: validatedEmail,
              ),
              SizedBox(height: 30.0),
              BtnFrave(
                text: 'Envoyer instructions',
                fontSize: 20,
                onPressed: () {
                  //if (_formKey.currentState!.validate()) {}
                  Navigator.push(context, routeFrave(page: CheckEmailPage()));
                },
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
