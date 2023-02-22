import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  // primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    // backwardsCompatibility: false,
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739')
  ),
  fontFamily: 'Jennah',
);

ThemeData ligthTheme = ThemeData(
  primarySwatch: Colors.grey,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    color: Colors.transparent,
    elevation: 0.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   type: BottomNavigationBarType.fixed,
  //   selectedItemColor: defaultColor,
  //   unselectedItemColor: Colors.grey,
  //   backgroundColor: Colors.white,
  // ),
  // fontFamily: 'Jennah',
);