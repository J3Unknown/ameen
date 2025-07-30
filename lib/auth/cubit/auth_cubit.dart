import 'dart:async';

import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utill/shared/values_manager.dart';

class AuthCubit extends Cubit<AuthCubitStates>{
  AuthCubit() : super(AuthInitState());

  static AuthCubit get(context) => BlocProvider.of(context);

  late bool canResendCode;
  int counter = AppSizes.s60;
  late Stream<int> _timerStream;
  late StreamController<int> _timerStreamController;
  Timer? _timer;

  Stream<int> get timerStream => _timerStream;

  void initializeStream() {
    _timerStreamController = StreamController<int>.broadcast();
    _timerStream = _timerStreamController.stream;
    canResendCode = false;
  }

  void timer() {
    _timer?.cancel();
    canResendCode = false;
    counter = AppSizes.s60;

    _timerStreamController.add(counter);
    _timer = Timer.periodic(Duration(seconds: AppSizes.s1), (timer) {
      counter--;
      _timerStreamController.add(counter);
      if (counter <= AppSizes.s0) {
        timer.cancel();
        canResendCode = true;
        emit(AuthFinishTimerState());
      }
    });
    emit(AuthStartTimerState(initialTime: counter));
  }

  @override
  Future<void> close(){
    if (_timer?.isActive ?? false){
      _timer?.cancel();
    }
    if (!_timerStreamController.isClosed) {
      _timerStreamController.close();
    }
    return super.close();
  }
}