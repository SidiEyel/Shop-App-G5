import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/login/cubit/state.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());


  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? model;

  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value){
      if(value.data !=null){
        model = LoginModel.formJson(value.data!);
        emit(ShopLoginSuccessState(model!));
      }else{
        ShopLoginErrorState('field to load data');
      }
      // model = value.data != null ? LoginModel.formJson(value.data!) : null;
      // print('Token');
      // //print(model!.data?.token);
      //
      // emit(ShopLoginSuccessState(model!));

    }).catchError((error){
      print('Error');
      print(error.toString());

      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility(){
    suffix = isPasswordShow ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPasswordShow = !isPasswordShow;

    emit(ShopChangePasswordVisibilityState());
  }

}