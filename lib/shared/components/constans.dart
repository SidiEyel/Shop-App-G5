import 'package:shop/modules/login/cubit/state.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

void SignOut(context){

  CacheHelper.removeData(key: 'token',).then((value){
    if(value){
      navigateAndFinish(
        context: context,
        widget: LoginScreen(),
      );
    }
  });
}

String token = '';