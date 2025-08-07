import 'dart:async';

import 'package:ameen/auth/cubit/auth_cubit_state.dart';
import 'package:ameen/utill/network/dio.dart';
import 'package:ameen/utill/network/end_points.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
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

  void login(String phone, String password){
    emit(AuthLoginLoadingState());
    DioHelper.postData(
      url: EndPoints.login,
      data: {
        KeysManager.phone: phone,
        KeysManager.password: password
      }
    ).then((value){
      //if(value[KeysManager.success])
      emit(AuthLoginSuccessState());
      //TODO: Add the returned value into the profile repo
    });
  }

  void register(String phone, String password, String name, String otpCode, String userType){
    emit(AuthRegisterLoadingState());
    DioHelper.postData(
      url: EndPoints.register,
      data: {
        KeysManager.phone: phone,
        KeysManager.password: password,
        KeysManager.name: name,
        KeysManager.otpCode: otpCode,
        KeysManager.type: userType,
      }
    ).then((value){
      //if(value[KeysManager.success])
      emit(AuthRegisterSuccessState());
      //TODO: Add the returned value into the profile repo
    });
  }

  void sendOtpRegister(String phone){
    emit(AuthSendOtpLoadingState());
    DioHelper.postData(
      url: EndPoints.register,
      data: {
        KeysManager.phone: phone,
      }
    ).then((value){
      //if(value[KeysManager.success])
      emit(AuthSendOtpSuccessState());
    });
  }

  void sendOtpForgotPassword(String phone){
    emit(AuthSendOtpLoadingState());
    DioHelper.postData(
      url: EndPoints.register,
      data: {
        KeysManager.phone: phone,
      }
    ).then((value){
      //if(value[KeysManager.success])
      emit(AuthSendOtpSuccessState());
    });
  }
}