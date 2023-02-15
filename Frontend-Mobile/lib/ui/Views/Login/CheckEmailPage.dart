import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commers/ui/Views/Login/login_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:android_intent_plus/android_intent.dart';
import '../../widgets/AnimationRoute.dart';
import 'package:e_commers/ui/widgets/widgets.dart';

class CheckEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 90.0),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                          color: ColorsFrave.primaryColorFrave.withOpacity(.1),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Icon(FontAwesomeIcons.envelopeOpenText,
                          size: 60, color: ColorsFrave.primaryColorFrave),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFrave(
                      text: 'vérifier votre courrier',
                      textAlign: TextAlign.center,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                  SizedBox(height: 20.0),
                  TextFrave(
                      text:
                          'nous avons envoyé des instructions de récupération de mot de passe à votre adresse email',
                      textAlign: TextAlign.center),
                  SizedBox(height: 40.0),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 70.0),
                      child: BtnFrave(
                        text: 'ouvrir email',
                        onPressed: () async {
                          if (Platform.isAndroid) {
                            final intent = AndroidIntent(
                                action: 'action_view',
                                package: 'com.android.email');
                            intent.launch();
                          }
                        },
                        width: 200.0,
                      )),
                  SizedBox(height: 40.0),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 70.0),
                      child: InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context, routeFrave(page: SignInPage())),
                          child: TextFrave(text: 'Sauter, je vais confirmerai plus tard '))),
                  SizedBox(height: 20.0),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  child: TextFrave(
                      text:
                          'vous n\'avez pas reçu email? vérifiez votre spam',
                      color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
