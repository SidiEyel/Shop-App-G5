import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/state.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constans.dart';
import '../../shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState){
            if(state.registerModel.status){

              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,).then((value){
                token = state.registerModel.data!.token;

                navigateAndFinish(
                  context: context,
                  widget: ShopLayout(),
                );
              }).catchError((error){
                print("error1");
              });

            } else {
              print('error');
              // print(state.registerModel?.message);
            }
          }
        },
        builder: (context,state){
          return  Scaffold(
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
                          'Register',
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
                                          Controller: nameController,
                                          keybord: TextInputType.text,
                                          text: 'name',
                                          prefix: Icons.person,
                                          validate: (String? value){
                                            if(value!.isEmpty){
                                              return "name must not be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                        defaultFormField(
                                          Controller: phoneController,
                                          keybord: TextInputType.emailAddress,
                                          text: 'phone',
                                          prefix: Icons.phone,
                                          validate: (String? value){
                                            if(value!.isEmpty){
                                              return "Phone must not be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                        defaultFormField(
                                          Controller: passwordController,
                                          keybord: TextInputType.visiblePassword,
                                          text: 'Password',
                                          prefix: Icons.lock_outline,
                                          suffix: ShopRegisterCubit.get(context).suffix,
                                          isPassword: ShopRegisterCubit.get(context).isPasswordShow,
                                          suffixPress: ()
                                          {
                                            ShopRegisterCubit.get(context).changePasswordVisibility();
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
                                          condition: state is! ShopRegisterLoadingState,
                                          builder: (context) => defaultButton(
                                            function: (){
                                              if(formKey.currentState!.validate())
                                              {
                                                ShopRegisterCubit.get(context).userRegister(
                                                  email: emailController.text,
                                                  password: passwordController.text,
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                );
                                              }
                                            },
                                            text: 'register',
                                          ),
                                          fallback:  (context) => const Center(child: CircularProgressIndicator()),
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
