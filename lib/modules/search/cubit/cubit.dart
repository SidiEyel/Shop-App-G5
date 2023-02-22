import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/search/cubit/state.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());


  static SearchCubit get(context) => BlocProvider.of(context);


  late ShearchModel model;
  void search(String text){
    DioHelper.putData(
        url: SEARCH,
      data: {
          'text':text,
      }).then((value){
        model = ShearchModel.fromJson(value.data);
        emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}