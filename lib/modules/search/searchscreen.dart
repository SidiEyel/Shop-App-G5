import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/cubit/cubit.dart';
import 'package:shop/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchcontroller = TextEditingController();
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SearchCubit(),
      child: BlocConsumer(
        listener: (context, state) {},
          builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
             children: [
                defaultFormField(
                Controller: searchcontroller,
                keybord: TextInputType.text,
                text: 'Search',
                prefix: Icons.search,
                validate: (){}
                ),
              ],
                ),
        );
                }
    ),
    );

  }
}
