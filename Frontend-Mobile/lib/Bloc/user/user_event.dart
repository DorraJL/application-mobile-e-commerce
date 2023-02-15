part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnGetUserEvent extends UserEvent {
  get user => user;
}

class OnGetDashEvent extends UserEvent {
  final DashboardModel model;
  OnGetDashEvent(this.model);
}

class OnAddNewUserEvent extends UserEvent {
  final String name;
  final String phone;
  final String email;
  final String password;

  OnAddNewUserEvent(this.name, this.phone, this.email, this.password);
}


class OnAddUserEvent extends UserEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String role;

  OnAddUserEvent(this.name, this.phone, this.email, this.password,this.role);
}
class OnSelectPictureEvent extends UserEvent {
  final String pictureProfilePath;

  OnSelectPictureEvent(this.pictureProfilePath);
}

class OnClearPicturePathEvent extends UserEvent {}

class OnChangeImageProfileEvent extends UserEvent {
  final String image;

  OnChangeImageProfileEvent(this.image);
}

class OnEditUserEvent extends UserEvent {
  final String name;

  final String phone;

  final String email;
  OnEditUserEvent(this.name, this.phone, this.email);
}

class OnChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  OnChangePasswordEvent(this.currentPassword, this.newPassword);
}

class OnRegisterDeliveryEvent extends UserEvent {
  final String name;
  final String lastname;
  final String phone;
  final String email;
  final String password;
  final String image;

  OnRegisterDeliveryEvent(this.name, this.lastname, this.phone, this.email,
      this.password, this.image);
}

class OnDeleteStreetAddressEvent extends UserEvent {
  final int uid;

  OnDeleteStreetAddressEvent(this.uid);
}

class OnAddNewAddressEvent extends UserEvent {
  final String street;
  final String reference;
  final LatLng location;

  OnAddNewAddressEvent(this.street, this.reference, this.location);
}
class OnDeleteUserEvent extends UserEvent {
  final String idUser;

  OnDeleteUserEvent(this.idUser);
}

class OnSelectAddressButtonEvent extends UserEvent {
  final int uidAddress;
  final String addressName;

  OnSelectAddressButtonEvent(this.uidAddress, this.addressName);
}

class OnUpdateDeliveryToClientEvent extends UserEvent {
  final String idPerson;

  OnUpdateDeliveryToClientEvent(this.idPerson);
}
