import 'package:shop/models/login_model.dart';

import '../../models/cart_model.dart';
import '../../models/change_cartes_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{

}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopCartsState extends ShopStates{}

class ShopSuccessCartsState extends ShopStates
{
  final CartsModel model;

  ShopSuccessCartsState(this.model);
}

class ShopErrorCartsState extends ShopStates{}

class ShopLoadingGetCartsState extends ShopStates{}

class ShopSuccessGetCartsState extends ShopStates{}

class ShopErrorGetCartsState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates
{
  final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}