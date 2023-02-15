part of 'user_bloc.dart';

@immutable
class UserState {
  final String pictureProfilePath;

  final int uidAddress;
  final String addressName;
  final DashboardModel? dash;
  final User? user;
  
  UserState(
      {this.uidAddress = 0,
      this.addressName = '',
      this.pictureProfilePath = '',
      this.dash,
      this.user,
    });

  UserState copyWith(
          {int? uidAddress,
          String? addressName,
          String? pictureProfilePath,
          DashboardModel? dash,
          User? user,
         }) =>
      UserState(
          uidAddress: uidAddress ?? this.uidAddress,
          addressName: addressName ?? this.addressName,
          pictureProfilePath: pictureProfilePath ?? this.pictureProfilePath,
          dash: dash ?? this.dash,
          user: user ?? this.user,
          );
}

class LoadingUserState extends UserState {}

class SuccessUserState extends UserState {}

class FailureUserState extends UserState {
  final String error;

  FailureUserState(this.error);
}










