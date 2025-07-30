abstract class AuthCubitStates{}

final class AuthInitState extends AuthCubitStates{}

final class AuthStartTimerState extends AuthCubitStates{
  final int initialTime;
  AuthStartTimerState({required this.initialTime});
}

final class AuthFinishTimerState extends AuthCubitStates{}