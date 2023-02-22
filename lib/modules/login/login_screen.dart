import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/constans.dart';
import 'package:shop/shared/styles/colors.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token,).then((value){
                    token = state.loginModel.data!.token;
                    navigateAndFinish(
                      context: context,
                      widget: ShopLayout(),
                    );
              });

            } else {
              print('error');
              print(state.loginModel.message);
              // showToast(
              //   message: state.loginModel.message,
              //   state: ToastStates.SUCCESS,
              // );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                  key: formKey,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.indigo.shade900,
                              Colors.indigo.shade800,
                              Colors.indigo.shade400
                            ]
                        )
                    ),
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(height: 70.0,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                'Welcom back',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60),),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0,),
                                        boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(0, 0, 153, 3),
                                          blurRadius: 20,
                                          offset: Offset(0,10)
                                        )]
                                      ),
                                      padding: EdgeInsets.all(20.0,),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                            ),
                                            child: Column(
                                              children: [
                                                defaultFormField(
                                                  Controller: emailController,
                                                  keybord: TextInputType.emailAddress,
                                                  text: 'Email Adress',
                                                  prefix: Icons.email,
                                                  validate: (String? value){
                                                    if(value!.isEmpty){
                                                      return "Email must not be empty";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                defaultFormField(
                                                          Controller: passwordController,
                                                          keybord: TextInputType.visiblePassword,
                                                          text: 'Password',
                                                          prefix: Icons.lock_outline,
                                                          suffix: ShopLoginCubit.get(context).suffix,
                                                          isPassword: ShopLoginCubit.get(context).isPasswordShow,
                                                          suffixPress: ()
                                                          {
                                                            ShopLoginCubit.get(context).changePasswordVisibility();
                                                          },
                                                          OnSubmit: (String value){
                                                            if(formKey.currentState!.validate())
                                                            {
                                                              ShopLoginCubit.get(context).userLogin(
                                                                email: emailController.text,
                                                                password: passwordController.text,
                                                              );
                                                            }
                                                          },
                                                          validate: (String? value){
                                                            if(value!.isEmpty){
                                                              return "Password is to short";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                SizedBox(height: 70.0,),
                                                ConditionalBuilder(

                                                  condition: state is! ShopLoginLoadingState,
                                                  builder: (context) => defaultButton(
                                                    function: (){
                                                      if(formKey.currentState!.validate())
                                                      {
                                                        ShopLoginCubit.get(context).userLogin(
                                                          email: emailController.text,
                                                          password: passwordController.text,
                                                        );
                                                      }
                                                    },
                                                    text: 'login',
                                                  ),
                                                  fallback:  (context) => const Center(child: CircularProgressIndicator()),
                                                ),

                                                SizedBox(height: 90.0,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:
                                                  [
                                                    const Text(
                                                        'Don\'t have an a account'
                                                    ),
                                                    const Spacer(),
                                                    defaultTextButton(
                                                      function: ()
                                                      {
                                                        navigateTo(
                                                          context: context,
                                                          widget: RegisterScreen(),
                                                        );
                                                      },
                                                      text: 'register now!',

                                                    ),

                                                  ],
                                                ),

                                              ],
                                            ),


                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),

                        // Expanded(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(60),
                        //         topRight: Radius.circular(60),
                        //       ),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(20.0),
                        //       child: Column(
                        //         children:
                        //         [
                        //           SizedBox(
                        //             height: 60,
                        //           ),
                        //
                        //           defaultFormField(
                        //             Controller: emailController,
                        //             keybord: TextInputType.emailAddress,
                        //             text: 'Email Adress',
                        //             prefix: Icons.email,
                        //             validate: (String? value){
                        //               if(value!.isEmpty){
                        //                 return "Email must not be empty";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //
                        //           const SizedBox(
                        //             height: 20.0,
                        //           ),
                        //
                        //           defaultFormField(
                        //             Controller: passwordController,
                        //             keybord: TextInputType.visiblePassword,
                        //             text: 'Password',
                        //             prefix: Icons.lock_outline,
                        //             suffix: ShopLoginCubit.get(context).suffix,
                        //             isPassword: ShopLoginCubit.get(context).isPasswordShow,
                        //             suffixPress: ()
                        //             {
                        //               ShopLoginCubit.get(context).changePasswordVisibility();
                        //             },
                        //             OnSubmit: (String value){
                        //               if(formKey.currentState!.validate())
                        //               {
                        //                 ShopLoginCubit.get(context).userLogin(
                        //                   email: emailController.text,
                        //                   password: passwordController.text,
                        //                 );
                        //               }
                        //             },
                        //             validate: (String? value){
                        //               if(value!.isEmpty){
                        //                 return "Password is to short";
                        //               }
                        //               return null;
                        //             },
                        //           ),
                        //
                        //           const SizedBox(
                        //             height: 30.0,
                        //           ),
                        //
                        //           ConditionalBuilder(
                        //
                        //             condition: state is! ShopLoginLoadingState,
                        //             builder: (context) => defaultButton(
                        //               function: (){
                        //                 if(formKey.currentState!.validate())
                        //                 {
                        //                   ShopLoginCubit.get(context).userLogin(
                        //                     email: emailController.text,
                        //                     password: passwordController.text,
                        //                   );
                        //                 }
                        //               },
                        //               text: 'login',
                        //             ),
                        //             fallback:  (context) => const Center(child: CircularProgressIndicator()),
                        //           ),
                        //           const SizedBox(
                        //             height: 15.0,
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children:
                        //             [
                        //               const Text(
                        //                   'Don\'t have an a account'
                        //               ),
                        //               const Spacer(),
                        //               defaultTextButton(
                        //                 function: ()
                        //                 {
                        //                   navigateTo(
                        //                     context: context,
                        //                     widget: RegisterScreen(),
                        //                   );
                        //                 },
                        //                 text: 'register now!',
                        //
                        //               ),
                        //
                        //             ],
                        //           ),
                        //
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
