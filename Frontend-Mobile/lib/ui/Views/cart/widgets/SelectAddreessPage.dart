import 'package:e_commers/Service/UserController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Bloc/user/user_bloc.dart';
import '../../../../Models/Response/AddressesResponse.dart';
import '../../../themes/colors_tech4iot.dart';
import '../../../widgets/shimmer_frave.dart';
import '../../../widgets/widgets.dart';

class SelectAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: TextFrave(text: 'Select Adresses'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColorFrave, size: 21),
              TextFrave(
                  text: 'Retour',
                  fontSize: 16,
                  color: ColorsFrave.primaryColorFrave)
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<ListAddress>?>(
          future: userServices.getAddresses(),
          builder: (context, snapshot) => (!snapshot.hasData)
              ? ShimmerFrave()
              : _ListAddresses(listAddress: snapshot.data!)),
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
            itemBuilder: (_, i) => Container(
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
                onTap: () => userBloc.add(OnSelectAddressButtonEvent(
                    listAddress[i].id, listAddress[i].reference)),
              ),
            ),
          )
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
         
          TextFrave(
              text: 'Sans Adresse',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: ColorsFrave.secundaryColorFrave),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
