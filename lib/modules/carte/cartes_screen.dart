import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/cart_model.dart';
import '../../models/cart_model.dart';
import '../../shared/styles/colors.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetCartsState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).carts!.data.data[index], context ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(width: double.infinity, height: 1, color: Colors.grey,),
            ),
            itemCount: ShopCubit.get(context).carts!.data.data.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(CartsData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height : 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product.image),
                width: 120.0,
                height: 120.0,
              ),
              if(model.product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                    color: defaultColor,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product.price.toString()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    if(model.product.discount != 0)
                      Text(
                        '${model.product.oldPrice.toString()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeCarts(model.product.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 24.0,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
