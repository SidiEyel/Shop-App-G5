
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state)
        {
          if(state is ShopSuccessCartsState)
          {
            if(!state.model.status)
            {
              // showToast(
              //     message: state.model.message,
              //     state: ToastStates.ERROR,
              // );
            }
          }
        },
        builder: (context, state){
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!, context ),
              fallback: (context) => const Center(child: CircularProgressIndicator(),),

          );
        },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SafeArea(
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CarouselSlider(
          //   items: model.data.banners.map((e) => Image(
          //     image: NetworkImage(e.image),
          //     width: double.infinity,
          //     fit: BoxFit.cover,
          //   ),).toList(),
          //   options: CarouselOptions(
          //     height: 200.0,
          //     initialPage: 0,
          //     viewportFraction: 1.0,
          //     enableInfiniteScroll: true,
          //     reverse: false,
          //     autoPlay: true,
          //     autoPlayInterval: const Duration(seconds: 3),
          //     autoPlayAnimationDuration: const Duration(seconds: 1),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(width: 10.0,),
                      itemCount: categoriesModel.data.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.transparent,
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 6.0,
              childAspectRatio: 1 / 1.5,
              children: List.generate(
                  model.data.products.length,
                    (index) => builderGridProduct(model.data.products[index], context),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget builderGridProduct(ProductModel model, context) => Container(
      height: MediaQuery.of(context).size.height * 0.3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              HexColor("353F54"),
              HexColor("222834"),
            ]
        )
    ),
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0,),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10.0,),
                  child: Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 150.0,
                  ),
                ),
              ),
              if(model.discount != 0)
                Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: const Text(
                  'Discount',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                    color: Colors.white
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(model.discount != 0)
                      Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.white60,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeCarts(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: (ShopCubit.get(context).Carts[model.id])! ? Colors.red.shade900 : Colors.white,
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 18.0,
                          color: Colors.grey,
                        ),
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

  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: Alignment.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8,),
        width: 100.0,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),

        ),
      ),
    ],
  );
}
