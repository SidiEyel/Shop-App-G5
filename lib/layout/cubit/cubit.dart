import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/carte/cartes_screen.dart';

import '../../models/cart_model.dart';
import '../../models/cart_model.dart';
import '../../models/cart_model.dart';
import '../../models/categories_model.dart';
import '../../models/change_cartes_model.dart';
import '../../models/cart_model.dart';
import '../../models/change_cartes_model.dart';
import '../../models/home_model.dart';
import '../../models/login_model.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/products/productsscreen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constans.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home,),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps,),
      label: 'Category',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite,),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings,),
      label: 'Settings',
    ),
  ];

  final items = const [
    Icon(Icons.home,color: Colors.white,),
    Icon(Icons.apps,color: Colors.white,),
    Icon(Icons.shopping_cart,color: Colors.white,),
    Icon(Icons.settings,color: Colors.white,),
  ];

  List<Widget> screens = [
    ProductsScreen(),
    CategoryScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  late Map<int, bool> Carts = {};

  void getHomeData(){

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
        url: HOME,
        token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel?.data.banners[0].image);

      homeModel!.data.products.forEach((element) {

        Carts.addAll(
          {
            element.id: element.inFavorites,
          });
      });

      //print(Carts.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error){


      emit(ShopErrorHomeDataState());
      print(error.toString());
    });

  }

  CategoriesModel? categoriesModel;

  void getCategoriesData(){

    DioHelper.getData(
      url: GET_CATEGORIES,
      lang: 'en',
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorCategoriesState());
    });

  }

  CartsModel? _cartsModel;

  void changeCarts(int productId){

    print(Carts[productId]);

    Carts[productId] = !Carts[productId]!;

    emit(ShopCartsState());

    DioHelper.postData(
      url: CARTES,
      token: token,
      data:
      {
        'product_id': productId,
      },

    ).then((value){


      _cartsModel = CartsModel.fromJson(value.data);

      if(!_cartsModel!.status)
      {
        Carts[productId] = !Carts[productId]!;
      }else{
        getCarts();
      }

      print(value.data);

      emit(ShopSuccessCartsState(_cartsModel!));

    }).catchError((error){

      Carts[productId] = !Carts[productId]!;

      emit(ShopErrorCartsState());
    });
  }


  CartsModel? carts;

  void getCarts(){

    emit(ShopLoadingGetCartsState());

    DioHelper.getData(
      url: CARTES,
      token: token,
      lang: 'en',
    ).then((value)
    {
      carts = CartsModel.fromJson(value.data);
      emit(ShopSuccessGetCartsState());
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorGetCartsState());
    });

  }




  LoginModel? userModel;

  void getUserData(){

    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
      lang: 'en',
    ).then((value)
    {
      if(value.data !=null){
        userModel = LoginModel.formJson(value.data!);
        emit(ShopSuccessUserDataState(userModel!));
      }else{
        ShopErrorUserDataState();
      }
    }).catchError((error){

      print(error.toString());
      emit(ShopErrorUserDataState());
    });

  }



}