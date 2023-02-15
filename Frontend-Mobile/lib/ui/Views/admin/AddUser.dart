import 'package:e_commers/Bloc/Password/general_bloc.dart';
import 'package:e_commers/ui/Views/admin/ListMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Helpers/validation_form.dart';
import 'package:e_commers/ui/themes/colors_tech4iot.dart';
import 'package:e_commers/ui/widgets/widgets.dart';
import 'package:select_form_field/select_form_field.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUser> {
  late TextEditingController userController;
  late TextEditingController emailController;
  late TextEditingController _phoneController;
  late TextEditingController passowrdController;
  late TextEditingController passController;
  late TextEditingController roleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userController = TextEditingController();
    emailController = TextEditingController();
    _phoneController = TextEditingController();
    passowrdController = TextEditingController();
    passController = TextEditingController();
    roleController = TextEditingController(text: 'select role');
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
    roleController.dispose();

    super.dispose();
  }

  void clear() {
    userController.clear();
    emailController.clear();
    passowrdController.clear();
    passController.clear();
    _phoneController.clear();
    roleController.clear();
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
              Navigator.pushReplacement(context, routeSlide(page: ListMenu()));
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
            actions: [SizedBox(width: 5)],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: 10.0),
                TextFrave(text: 'Ajouter admin/livreur', fontSize: 18),
                SizedBox(height: 20.0),
                TextFormFrave(
                  hintText: 'Nom',
                  prefixIcon: Icon(Icons.person),
                  controller: userController,
                  validator: RequiredValidator(errorText: 'nom est requis'),
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
                            ])),
                SizedBox(height: 15.0),
                SelectFormField(
                  controller: roleController,
                  type: SelectFormFieldType.dropdown, // or can be dialog
                  labelText: 'role',
                  items: _items,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  validator: RequiredValidator(errorText: 'role est requis'),
                ),
                SizedBox(height: 100.0),
                BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) => BtnFrave(
                          text: 'Ajouter',
                          width: size.width,
                          fontSize: 20,
                          backgroundColor: ColorsFrave.secundaryColorFrave,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              userBloc.add(OnAddUserEvent(
                                  userController.text.trim(),
                                  _phoneController.text.trim(),
                                  emailController.text.trim(),
                                  passowrdController.text.trim(),
                                  roleController.text.trim()));
                            }
                          },
                        )),
              ],
            ),
          ),
        ));
  }
}

final List<Map<String, dynamic>> _items = [
  {
    'value': 'livreur',
    'label': 'livreur',
  },
  {
    'value': 'admin',
    'label': 'admin',
  },
   {
    'value': 'Supadmin',
    'label': 'Supadmin',
  },
];
