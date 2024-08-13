import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/favoriteScreen/presition/view/favoritesceen.dart';
import 'package:origami/features/product/presentation/view/products_view.dart';
import 'package:origami/features/profile/prestion/view/profile_screen.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';
import 'package:origami/features/Weight/prestion/view/weight.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

  ProfileModel? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataGloble.PointAll = 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int selectedindex = 0;
  List<Widget> pages = [
    const Products(),
    const Weight(),
    const Favoritescreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: IconThemeData(size: 20.sp),
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.grey),
          selectedIconTheme: IconThemeData(size: 22.sp),
          currentIndex: selectedindex,
          selectedItemColor: kPrimarycolor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              selectedindex = index;
            });
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
          ]),
      body: pages.elementAt(selectedindex),
    );
  }
}
