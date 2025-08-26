import 'dart:async';
import 'dart:developer';

import 'package:ameen/Repo/profile_data_model.dart';
import 'package:ameen/Repo/repo.dart';
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
      if(value.data[KeysManager.success]){
        Repo.profileDataModel = ProfileDataModel.fromJson(value.data[KeysManager.result]);
        emit(AuthLoginSuccessState(Repo.profileDataModel!));
      } else {
        emit(AuthLoginErrorState());
      }
    });
  }

  void register(String phone, String password, String name, String email, String otpCode){
    emit(AuthRegisterLoadingState());
    DioHelper.postData(
      url: EndPoints.register,
      data: {
        KeysManager.phone: phone,
        KeysManager.password: password,
        KeysManager.name: name,
        KeysManager.email: email,
        KeysManager.otpCode: otpCode,
        KeysManager.type: 'User',
      }
    ).then((value){
      if(value.data[KeysManager.success]){
        Repo.profileDataModel = ProfileDataModel.fromJson(value.data[KeysManager.result]);
        emit(AuthRegisterSuccessState(Repo.profileDataModel!));
      } else {
        emit(AuthRegisterErrorState(value.data['msg']));
      }
    });
  }

  int? otpCode;
  void sendOtpRegister(String phone){
    emit(AuthSendOtpLoadingState());
    DioHelper.postData(
      url: EndPoints.otpRegister,
      data: {
        KeysManager.phone: int.parse(phone),
      }
    ).then((value){
      if(value.data[KeysManager.success]){
        otpCode = value.data[KeysManager.result][KeysManager.otpUCode];
      }
      emit(AuthSendOtpSuccessState());
    });
  }

  void sendOtpForgotPassword(String phone){
    emit(AuthSendOtpLoadingState());
    DioHelper.postData(
      url: EndPoints.otpForgotPassword,
      data: {
        KeysManager.phone: phone,
      }
    ).then((value){
      emit(AuthSendOtpSuccessState());
    });
  }

  void representativeLogin(String phone, String password){
    emit(AuthLoginLoadingState());
    DioHelper.postData(
      isDelivery: true,
      url: EndPoints.login,
      data: {
        KeysManager.phone:phone,
        KeysManager.password:password
      }
    ).then((value){
      if(value.data[KeysManager.success]){
        Repo.profileDataModel = ProfileDataModel.fromJson(value.data[KeysManager.result]);
        emit(AuthLoginSuccessState(Repo.profileDataModel!));
      } else {
        emit(AuthLoginErrorState());
      }
    });
  }

  void logout({bool isDelivery = false}){
    emit(AuthLogoutLoadingState());
    DioHelper.getData(isDelivery: isDelivery, path: EndPoints.logout).then((value){
      emit(AuthLogoutSuccessState());
    });
  }

  void getSahlOtp(){
    emit(AuthSendOtpLoadingState());
    DioHelper.postData(url: EndPoints.sendSahlOtp).then((value){
      if(value.data[KeysManager.success]){
        otpCode = value.data[KeysManager.result][KeysManager.otpUCode];
        emit(AuthSendOtpLoadingState());
      } else {
        emit(AuthSendOtpErrorState());
      }
    });
  }
}
