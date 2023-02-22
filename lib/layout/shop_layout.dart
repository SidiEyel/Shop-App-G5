import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../modules/search/searchscreen.dart';
import '../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Shop',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: ()
                  {
                    navigateTo(
                      context: context,
                      widget: SearchScreen(),
                    );
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('assets/images/back.png'),
                        fit: BoxFit.cover,
                        ),
                      ),
                  child: cubit.screens[cubit.currentIndex]
              ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: HexColor("#99c2ff"),
              color: HexColor("#4087EB"),
              index: cubit.currentIndex,
              height: 60.0,
              onTap: (index)
              {
                cubit.changeBottom(index);
              },
              items: cubit.items,
            ),
          );
        },
      );
  }
}
