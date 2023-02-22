import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/cubit/state.dart';
import 'package:shop/modules/register/cubit/state.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? model;

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value){

      if(value.data !=null) {
        model = LoginModel.formJson(value.data!);

        ShopRegisterSuccessState(model!);
      }else{
        ShopRegisterErrorState('can not upload data');
      }
      // model = value.data != null ? LoginModel.formJson(value.data!) : null;
      // print('Token');
      // // print(model!.data.token);
      //
      // emit(ShopRegisterSuccessState(model!));

    }).catchError((error){
      print(error);
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility(){
    suffix = isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPasswordShow = !isPasswordShow;

    emit(ShopRegisterChangePasswordVisibilityState());
  }

}