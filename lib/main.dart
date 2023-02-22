import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/constans.dart';
import 'package:shop/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/shop_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'shared/Bloc_Observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = LoginScreen();
  }else
  {
    widget = OnBoardingScreen();
  }

  // WidgetsFlutterBinding.ensureInitialized();
  // //
  // // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.removeAfter(initialization);

  runApp(MyApp(widget));
}

// Future initialization(BuildContext? context) async {
//
//   await Future.delayed(Duration(seconds: 6));
// }
class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp(this.startWidget);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getCarts()..getUserData(),),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ligthTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }

}

