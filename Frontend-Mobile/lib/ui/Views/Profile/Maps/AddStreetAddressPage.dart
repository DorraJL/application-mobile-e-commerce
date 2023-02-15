import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/ui/Views/Profile/Maps/MapAddressPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../Bloc/MyLocation/mylocationmap_bloc.dart';
import '../../../../Bloc/user/user_bloc.dart';
import '../../../themes/colors_tech4iot.dart';
import '../../../widgets/AnimationRoute.dart';
import '../../../widgets/widgets.dart';
import '../widgets/ListAddressesPage.dart';

class AddStreetAddressPage extends StatefulWidget {
  @override
  _AddStreetAddressPageState createState() => _AddStreetAddressPageState();
}

class _AddStreetAddressPageState extends State<AddStreetAddressPage> {
  late TextEditingController _streetAddressController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    _streetAddressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _streetAddressController.clear();
    _streetAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final myLocationBloc = BlocProvider.of<MylocationmapBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoadingShort(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSucces(
              context,
              'Adresse ajouté avec succès',
              () => Navigator.pushReplacement(
                  context, routeFrave(page: ListAddressesPage())));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'nouvelle adresse', fontSize: 19),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context, routeFrave(page: ListAddressesPage())),
              child: TextFrave(
                  text: 'Annuler',
                  color: ColorsFrave.primaryColorFrave,
                  fontSize: 17)),
          actions: [
            TextButton(
                onPressed: () async {
                  if (_keyForm.currentState!.validate()) {
                    userBloc.add(OnAddNewAddressEvent(
                        _streetAddressController.text.trim(),
                        myLocationBloc.state.addressName!,
                        myLocationBloc.state.locationCentral!));
                  }
                },
                child: TextFrave(
                    text: 'Enregistrer',
                    color: ColorsFrave.primaryColorFrave,
                    fontSize: 17)),
          ],
        ),
        body: SafeArea(
          child: Form(
            key: _keyForm,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFrave(text: 'Rue'),
                  SizedBox(height: 5.0),
                  FormFieldFrave(
                    controller: _streetAddressController,
                    validator: RequiredValidator(
                        errorText: 'champs obligatoire '),
                  ),
                  SizedBox(height: 20.0),
                  TextFrave(text: 'Reference'),
                  SizedBox(height: 5.0),
                  InkWell(
                    onTap: () async {
                      final permissionGPS = await Permission.location.isGranted;
                      final gpsActive =
                          await Geolocator.isLocationServiceEnabled();

                      if (permissionGPS && gpsActive) {
                        Navigator.push(
                            context,
                            navigatorPageFadeInFrave(
                                context, MapLocationAddressPage()));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: .5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: BlocBuilder<MylocationmapBloc, MylocationmapState>(
                          builder: (_, state) => TextFrave(
                                text: state.addressName!,
                              )),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextFrave(
                          text: 'Appuyez pour sélectionner la direction',
                          fontSize: 16,
                          color: Colors.grey))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
