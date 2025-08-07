abstract class AuthCubitStates{}

final class AuthInitState extends AuthCubitStates{}

final class AuthStartTimerState extends AuthCubitStates{
  final int initialTime;
  AuthStartTimerState({required this.initialTime});
}

final class AuthFinishTimerState extends AuthCubitStates{}

final class AuthLoginLoadingState extends AuthCubitStates{}

final class AuthLoginSuccessState extends AuthCubitStates{}

final class AuthLoginErrorState extends AuthCubitStates{}

final class AuthRegisterLoadingState extends AuthCubitStates{}

final class AuthRegisterSuccessState extends AuthCubitStates{}

final class AuthRegisterErrorState extends AuthCubitStates{}

final class AuthSendOtpLoadingState extends AuthCubitStates{}

final class AuthSendOtpSuccessState extends AuthCubitStates{}

final class AuthSendOtpErrorState extends AuthCubitStates{}