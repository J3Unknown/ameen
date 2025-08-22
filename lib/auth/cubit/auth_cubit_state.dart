import 'package:ameen/Repo/profile_data_model.dart';

abstract class AuthCubitStates{}

final class AuthInitState extends AuthCubitStates{}

final class AuthStartTimerState extends AuthCubitStates{
  final int initialTime;
  AuthStartTimerState({required this.initialTime});
}

final class AuthFinishTimerState extends AuthCubitStates{}

final class AuthLoginLoadingState extends AuthCubitStates{}

final class AuthLoginSuccessState extends AuthCubitStates{
  ProfileDataModel profileDataModel;

  AuthLoginSuccessState(this.profileDataModel);
}

final class AuthLoginErrorState extends AuthCubitStates{}

final class AuthRegisterLoadingState extends AuthCubitStates{}

final class AuthRegisterSuccessState extends AuthCubitStates{
  ProfileDataModel profileDataModel;

  AuthRegisterSuccessState(this.profileDataModel);
}

final class AuthRegisterErrorState extends AuthCubitStates{
  final String message;
  AuthRegisterErrorState(this.message);
}

final class AuthSendOtpLoadingState extends AuthCubitStates{}

final class AuthSendOtpSuccessState extends AuthCubitStates{}

final class AuthSendOtpErrorState extends AuthCubitStates{}

final class AuthLogoutLoadingState extends AuthCubitStates{}

final class AuthLogoutSuccessState extends AuthCubitStates{}

final class AuthLogoutErrorState extends AuthCubitStates{}