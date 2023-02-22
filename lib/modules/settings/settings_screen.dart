import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constans.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name;
        phoneController.text = model.data!.phone;
        emailController.text = model.data!.email;

        return SafeArea(
          child: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                  defaultFormField(
                    Controller: nameController,
                    keybord: TextInputType.name,
                    text: 'name',
                    color: Colors.white,
                    prefix: Icons.person,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                    Controller: emailController,
                    keybord: TextInputType.emailAddress,
                    text: 'Email Adresse',
                    color: Colors.white,
                    prefix: Icons.email,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  defaultFormField(
                    Controller: phoneController,
                    keybord: TextInputType.name,
                    text: 'Phone',
                    color: Colors.white,
                    prefix: Icons.phone,
                    validate: (String value)
                    {
                      if(value.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                  ),

                  defaultButton(
                      function: ()
                      {
                        SignOut(context);
                      },
                      text: 'logout',
                  ),

                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
