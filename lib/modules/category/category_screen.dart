import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../shared/styles/colors.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state){
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => categoriesBuilder(ShopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(width: double.infinity,height: 1.0, color: Colors.grey[300],),
              ),
              itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          );
        },
    );
  }

  Widget categoriesBuilder(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
        children:
        [
          Image(
            image: NetworkImage(model.image),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: defaultColor,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
            ),)
        ],
    ),
      );
}
