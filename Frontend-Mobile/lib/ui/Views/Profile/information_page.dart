import 'package:e_commers/ui/Views/Home/home_page.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/shimmer_frave.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  final _keyForm = GlobalKey<FormState>();

  Future<void> getPersonalInformation() async {
    final userBloc = BlocProvider.of<UserBloc>(context).state.user!;

    _nameController = TextEditingController(text: userBloc.firstName);
    
    _phoneController = TextEditingController(text: userBloc.phone);
    _emailController = TextEditingController(text: userBloc.email);
  }

  @override
  void initState() {
    super.initState();
    getPersonalInformation();
  }

  @override
  void dispose() {
    _nameController.clear();
  
    _phoneController.clear();
    _emailController.clear();
    _nameController.dispose();

    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoadingShort(context);
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, 'succes', onPressed: () {
            Navigator.push(context, routeSlide(page: HomePage()));
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 80,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorsFrave.primaryColorFrave, size: 17),
                TextFrave(
                    text: 'Retour',
                    fontSize: 17,
                    color: ColorsFrave.primaryColorFrave)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnEditUserEvent(
                      _nameController.text,
                      _phoneController.text,
                      _emailController.text

                    ));
                  }
                },
                child: TextFrave(
                    text: 'Modifier le Profil',
                    fontSize: 16,
                    color: Colors.amber[900]!))
          ],
        ),
        body: SafeArea(
          child: Form(
              key: _keyForm,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                children: [
                  TextFrave(
                      text: 'Nom', color: ColorsFrave.secundaryColorFrave),
                  SizedBox(height: 5.0),
                  FormFieldFrave(
                      controller: _nameController,
                      validator:
                          RequiredValidator(errorText: 'champs obligatoire')),
                  SizedBox(height: 20.0),
                 
                
                  TextFrave(
                      text: 'Telehone', color: ColorsFrave.secundaryColorFrave),
                  SizedBox(height: 5.0),
                  FormFieldFrave(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    hintText: '000-000-00',
                  ),
                  SizedBox(height: 20.0),
                  TextFrave(
                      text: 'Email Adresse',
                      color: ColorsFrave.secundaryColorFrave),
                  SizedBox(height: 5.0),
                  FormFieldFrave(controller: _emailController),
                  SizedBox(height: 20.0),
                ],
              )),
        ),
      ),
    );
  }
}
