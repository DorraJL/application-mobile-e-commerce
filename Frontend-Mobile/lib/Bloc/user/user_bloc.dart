import 'package:bloc/bloc.dart';
import 'package:e_commers/Models/Response/DashboardResponse.dart';
import 'package:e_commers/Models/Response/response_auth.dart';
import 'package:e_commers/Service/UserController.dart';
import 'package:meta/meta.dart';
import 'package:e_commers/Service/PushNotification.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<OnGetUserEvent>(_onGetUser);
    on<OnGetDashEvent>(_onGetDash);
    on<OnSelectPictureEvent>(_onSelectPicture);
    // on<OnAddNewUser>(_addNewUser);
    on<OnClearPicturePathEvent>(_onClearPicturePath);
    on<OnEditUserEvent>(_onEditProfileUser);
    on<OnChangePasswordEvent>(_onChangePassword);
    /* on<OnChangeImageProfileEvent>( _onChangePictureProfile );
    on<OnEditUserEvent>( _onEditProfileUser );
    on<OnChangePasswordEvent>( _onChangePassword );
    on<OnRegisterClientEvent>( _onRegisterClient );
    on<OnRegisterDeliveryEvent>( _onRegisterDelivery );
    on<OnUpdateDeliveryToClientEvent>( _onUpdateDeliveryToClient );
   */
    on<OnDeleteStreetAddressEvent>(_onDeleteStreetAddress);
    on<OnSelectAddressButtonEvent>(_onSelectAddressButton);
     on<OnDeleteUserEvent>(_onDeleteUser);

    on<OnAddNewAddressEvent>(_onAddNewStreetAddress);
    on<OnAddNewUserEvent>(_onRegisterClient);
    on<OnAddUserEvent>(_onRegisterUser);
  }

  /*Future<void> _addNewUser(OnAddNewUser event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userServices.addNewUser(
          event.username, event.email, event.password);

      if (data.resp) {
        emit(SuccessUserState());
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }*/

  Future<void> _onGetUser(OnGetUserEvent event, Emitter<UserState> emit) async {
    final user = await userServices.getUserById();
    emit(state.copyWith(user: user));
  }

  Future<void> _onGetDash(OnGetDashEvent event, Emitter<UserState> emit) async {
    final model = await userServices.dashboard();
    emit(state.copyWith(dash: model));
  }

  Future<void> _onSelectPicture(
      OnSelectPictureEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(pictureProfilePath: event.pictureProfilePath));
  }

  Future<void> _onClearPicturePath(
      OnClearPicturePathEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(pictureProfilePath: ''));
  }

  /*Future<void> _onChangePictureProfile( OnChangeImageProfileEvent event, Emitter<UserState> emit ) async {

    try {

      emit( LoadingUserState() );

      final data = await userServices.changeImageProfile(event.image);

      if( data.resp ){

        final user = await userServices.getUserById();

        emit( SuccessUserState() );

        emit( state.copyWith( user: user! ) );

      }else{
        emit( FailureUserState(data.msg) );
      }
      
    } catch (e) {
      emit( FailureUserState(e.toString()) );
    }

  }*/

  Future<void> _onEditProfileUser(
      OnEditUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data =
          await userServices.editProfile(event.name, event.phone, event.email);

      if (data.resp) {
        final user = await userServices.getUserById();

        emit(SuccessUserState());

        emit(state.copyWith(user: user));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onChangePassword(
      OnChangePasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userServices.changePassword(
          event.currentPassword, event.newPassword);

      if (data.resp) {
        final user = await userServices.getUserById();

        emit(SuccessUserState());

        emit(state.copyWith(user: user));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onRegisterClient(
      OnAddNewUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      //final nToken = await pushNotification.getNotificationToken();

      final data = await userServices.registerClient(
          event.name, event.phone, event.email, event.password);

      if (data.resp)
        emit(SuccessUserState());
      else
        emit(FailureUserState(data.message));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onRegisterUser(
      OnAddUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      //final nToken = await pushNotification.getNotificationToken();

      final data = await userServices.registerUser(
          event.name, event.phone, event.email, event.password, event.role);

      if (data.resp)
        emit(SuccessUserState());
      else
        emit(FailureUserState(data.message));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

/*
  Future<void> _onRegisterDelivery( OnRegisterDeliveryEvent event, Emitter<UserState> emit) async {

    try {

      emit( LoadingUserState() );

      final nToken = await pushNotification.getNotificationToken();

      final data = await userServices.registerDelivery(event.name, event.lastname, event.phone, event.email, event.password, event.image, nToken!);

      if( data.resp ) {
        
        final user = await userServices.getUserById();

        emit( SuccessUserState() );

        emit( state.copyWith( user: user ));

      } else emit( FailureUserState(data.msg));
      
    } catch (e) {
      emit( FailureUserState(e.toString()) );
    }

  }

  Future<void> _onUpdateDeliveryToClient( OnUpdateDeliveryToClientEvent event, Emitter<UserState> emit) async {

    try {

      emit( LoadingUserState() );

      final data = await userServices.updateDeliveryToClient(event.idPerson);

      if( data.resp ){

        final user = await userServices.getUserById();

        emit( SuccessUserState() );

        emit( state.copyWith(user: user) );

      }else{
        emit( FailureUserState(data.msg) );
      }
      
    } catch (e) {
      emit( FailureUserState(e.toString()));
    }

  }

 */
  Future<void> _onDeleteStreetAddress(
      OnDeleteStreetAddressEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userServices.deleteStreetAddress(event.uid.toString());

      if (data.resp) {
        final user = await userServices.getUserById();

        emit(SuccessUserState());

        emit(state.copyWith(user: user));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }

  Future<void> _onSelectAddressButton(
      OnSelectAddressButtonEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(
        uidAddress: event.uidAddress, addressName: event.addressName));
  }

Future<void> _onDeleteUser(
      OnDeleteUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userServices.deleteUser(event.idUser);

      await Future.delayed(Duration(seconds: 1));

      if (data.resp)
        emit(SuccessUserState());
      else
        emit(FailureUserState(data.message));
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }


  Future<void> _onAddNewStreetAddress(
      OnAddNewAddressEvent event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());

      final data = await userServices.addNewAddressLocation(
          event.street,
          event.reference,
          event.location.latitude.toString(),
          event.location.longitude.toString());

      if (data.resp) {
        final user = await userServices.getUserById();

        final userdb = await userServices.getAddressOne();

        add(OnSelectAddressButtonEvent(
            userdb.address!.id, userdb.address!.reference));

        emit(SuccessUserState());

        emit(state.copyWith(user: user));
      } else {
        emit(FailureUserState(data.message));
      }
    } catch (e) {
      emit(FailureUserState(e.toString()));
    }
  }
}
