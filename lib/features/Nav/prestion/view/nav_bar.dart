import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/favoriteScreen/presition/view/favoritesceen.dart';
import 'package:origami/features/product/presentation/view/products_view.dart';
import 'package:origami/features/profile/prestion/view/profile_screen.dart';
import 'package:origami/features/Weight/prestion/view/weight.dart';

import '../../cubit/nav_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          final pages = [
            const Products(),
            const Weight(),
            const Favoritescreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            extendBody: true,
            bottomNavigationBar: BottomNavigationBar(
              unselectedIconTheme: IconThemeData(size: 20.sp),
              selectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: Colors.grey),
              selectedIconTheme: IconThemeData(size: 22.sp),
              currentIndex: state.selectedIndex,
              selectedItemColor: kPrimarycolor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                context.read<NavCubit>().selectPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_checkout_rounded),
                    label: 'المنتجات'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.monitor_weight_rounded), label: 'الميزان'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'المفضل '),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'الملف الشخصي'),
              ],
            ),
            body: pages[state.selectedIndex],
          );
        },
      ),
    );
  }
}
