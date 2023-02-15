import 'package:e_commers/Helpers/helpers.dart';
import 'package:e_commers/Service/UserController.dart';
import 'package:e_commers/ui/Views/Profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commers/Bloc/user/user_bloc.dart';
import 'package:e_commers/Models/Response/AddressesResponse.dart';
import '../../../themes/colors_tech4iot.dart';
import '../../../widgets/AnimationRoute.dart';
import '../../../widgets/shimmer_frave.dart';
import '../../../widgets/widgets.dart';
import '../Maps/AddStreetAddressPage.dart';

class ListAddressesPage extends StatefulWidget {
  @override
  _ListAddressesPageState createState() => _ListAddressesPageState();
}

class _ListAddressesPageState extends State<ListAddressesPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        Navigator.push(context, routeFrave(page: AddStreetAddressPage()));
      }
    }
  }

  void accessLocation(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.push(context, routeFrave(page: AddStreetAddressPage()));
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoadingShort(context);
        } else if (state is SuccessUserState) {
          Navigator.pop(context);

          Navigator.push(context, routeSlide(page: ListAddressesPage()));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFrave(text: 'Liste Adresses', fontSize: 19),
          centerTitle: true,
          elevation: 0,
          leadingWidth: 80,
          leading: TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context, routeFrave(page: ProfilePage())),
              child: TextFrave(
                  text: 'Annuler',
                  color: ColorsFrave.primaryColorFrave,
                  fontSize: 17)),
          actions: [
            TextButton(
                onPressed: () async =>
                    accessLocation(await Permission.location.request()),
                child: TextFrave(
                    text: 'Ajouter',
                    color: ColorsFrave.primaryColorFrave,
                    fontSize: 17)),
          ],
        ),
        body: FutureBuilder<List<ListAddress>?>(
            future: userServices.getAddresses(),
            builder: (context, snapshot) => (!snapshot.hasData)
                ? ShimmerFrave()
                : _ListAddresses(listAddress: snapshot.data!)),
      ),
    );
  }
}

class _ListAddresses extends StatelessWidget {
  final List<ListAddress> listAddress;

  const _ListAddresses({Key? key, required this.listAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return (listAddress.length != 0)
        ? ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            itemCount: listAddress.length,
            itemBuilder: (_, i) => Dismissible(
                  key: Key(listAddress[i].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(),
                  onDismissed: (direction) => userBloc
                      .add(OnDeleteStreetAddressEvent(listAddress[i].id)),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Icon(Icons.delete_sweep_rounded,
                        color: Colors.white, size: 38),
                  ),
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      leading: BlocBuilder<UserBloc, UserState>(
                          builder: (_, state) =>
                              (state.uidAddress == listAddress[i].id)
                                  ? Icon(Icons.radio_button_checked_rounded,
                                      color: ColorsFrave.primaryColorFrave)
                                  : Icon(Icons.radio_button_off_rounded)),
                      title: TextFrave(
                          text: listAddress[i].street,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      subtitle: TextFrave(
                          text: listAddress[i].reference,
                          fontSize: 16,
                          color: ColorsFrave.secundaryColorFrave),
                      trailing: Icon(Icons.swap_horiz_rounded,
                          color: Colors.red[300]),
                      onTap: () => userBloc.add(OnSelectAddressButtonEvent(
                          listAddress[i].id, listAddress[i].reference)),
                    ),
                  ),
                ))
        : _WithoutListAddress();
  }
}

class _WithoutListAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset('Assets/my-location.svg', height: 400),
          TextFrave(
              text: 'Sans adresse',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: ColorsFrave.secundaryColorFrave),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
