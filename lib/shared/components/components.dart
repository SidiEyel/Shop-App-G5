import 'package:clay_containers/clay_containers.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';

import '../styles/colors.dart';

Widget defaultFormField({
  required TextEditingController Controller,
  required TextInputType keybord,
  required String text,
  required IconData prefix,
  bool isPassword =false,
  IconData? suffix,
  required Function validate,
  Function? OnSubmit,
  Function? suffixPress,
  Color color = Colors.grey,
}) => TextFormField(

    keyboardType: keybord,

    controller: Controller,

    obscureText: isPassword,

    onFieldSubmitted: (String value){

      return OnSubmit!(value);

    },

    validator: (String? value) {

        return validate(value);

        },

    decoration: InputDecoration(

      labelText: text,

      prefixIcon: Icon(

        prefix,
        color: color,
      ),

      suffixIcon: suffix != null ?

      IconButton(

        onPressed: (){

          return suffixPress!();

        },

        icon: Icon(

          suffix,

        ),

      ) : null,

      labelStyle: TextStyle(color: color,),

    ),

  );


Widget defaultButton({
  required Function? function,
  required String text,
  bool isUppercase=true,
  Color background = Colors.blue,
  double width=double.infinity,
}) => Row(
  children: [
    Text(
      isUppercase ? text.toUpperCase() : text,
      style: TextStyle(
        color: secondColor,
        fontSize: 22.0,
      ),
    ),
    Spacer(),
    NeumorphicButton(
      onPressed: (){return function!();},
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
        color: secondColor,
      ),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 30.0,
      ),
    ),
  ],
);

Widget defaultTextButton({
  required Function? function,
  required String text,
}) => TextButton(
  onPressed: () {
    return function!();
  },
  child: Text(text.toUpperCase(),
  style: TextStyle(
    color: secondColor,
  ),),
);

void navigateTo({
  context,
  widget,
}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish({context,widget}) =>

    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => widget),
    (route)=>false,
  );

// void showToast({
//   required String? message,
//   required ToastStates? state,
// }) => Fluttertoast.showToast(
//       msg: message!,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state!),
//       textColor: Colors.white,
//       fontSize: 16.0
//   );


enum ToastStates {SUCCESS, ERROR, WARNING}

Color? chooseToastColor(ToastStates state){

  Color? color;
  switch(state)
  {
    case (ToastStates.SUCCESS):
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.red;
      break;
  }

  return color;

}

Widget backgroundScreen({
  required Size size,
  Color white = Colors.white60,
}) => Stack(

  children: [
    Container(
      color: white,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClayContainer(
                  color: white,
                  width: 220,
                  height: 220,
                  borderRadius: 200,
                  depth: -50,
                  curveType: CurveType.convex,
                ),
                ClayContainer(
                  color: white,
                  width: 180,
                  height: 180,
                  borderRadius: 200,
                  depth: 50,
                ),
                ClayContainer(
                  color: white,
                  width: 140,
                  height: 140,
                  borderRadius: 200,
                  depth: -50,
                  curveType: CurveType.convex,
                ),
                ClayContainer(
                  color: white,
                  width: 100,
                  height: 100,
                  borderRadius: 200,
                  depth: 50,
                ),
              ],
            ),
            right: 0,
            top: -size.height * 0.05,
          )
        ],
      ),
    ),
    Container(
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClayContainer(
                  color: white,
                  width: 160,
                  height: 160,
                  borderRadius: 200,
                  depth: 50,
                  curveType: CurveType.convex,
                ),
                ClayContainer(
                  color: white,
                  width: 140,
                  height: 140,
                  borderRadius: 200,
                  depth: -50,
                  curveType: CurveType.convex,
                ),
                ClayContainer(
                  color: white,
                  width: 70,
                  height: 70,
                  borderRadius: 200,
                  depth: 50,
                ),
              ],
            ),
            left: -size.width * 0.05,
            bottom: size.height * 0.1,
          )
        ],
      ),
    ),
    Container(
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClayContainer(
                  color: white,
                  width: 100,
                  height: 100,
                  borderRadius: 200,
                  depth: 50,
                  curveType: CurveType.convex,
                ),
                ClayContainer(
                  color: white,
                  width: 80,
                  height: 80,
                  borderRadius: 200,
                  depth: -50,
                  curveType: CurveType.convex,
                )
              ],
            ),
            left: size.width * 0.52,
            bottom: 10,
          )
        ],
      ),
    )
  ],
);

Widget back() =>Container(
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      colors: [
        Colors.orange.shade900,
        Colors.orange.shade800,
        Colors.orange.shade400
      ]
    )
  ),
  child: Column(),
);
