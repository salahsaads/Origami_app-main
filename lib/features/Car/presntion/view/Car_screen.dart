import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view_model/car_prodect_model.dart';

class Car_screen extends StatefulWidget {
  const Car_screen({super.key});

  @override
  State<Car_screen> createState() => _Car_screenState();
}

class _Car_screenState extends State<Car_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimarycolor,
          centerTitle: true,
          title: Icon(
            Icons.shopping_cart,
            size: 30.sp,
            color: kSecondarycolor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
          child: SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.4,
                mainAxisSpacing: 5,
                crossAxisCount: 1,
              ),
              itemCount: 3,
              itemBuilder: (context, index) => CardModel2(
                image: 'assets/images/product.png',
                productname: 'salah',
                productpoints: 150,
              ),
            ),
          ),
        ));
  }
}
