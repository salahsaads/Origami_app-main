import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view/Car_screen.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({
    super.key,
    required this.userphone,
    required this.points,
    required this.querySnapshot2,
  });

  final String? userphone;
  final int points;
  final QuerySnapshot<Object?>? querySnapshot2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CarScreen(
                      number: userphone,
                      allpoint: points * 1.0,
                    )));
      },
      child: Stack(
        children: [
          Container(
            width: 60.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: kSecondarycolor,
            ),
            child: Icon(Icons.shopping_cart, size: 30.sp),
          ),
          Positioned(
            right: 1,
            child: Container(
              alignment: Alignment.center,
              // ignore: sort_child_properties_last
              child: Text(
                querySnapshot2 != null ? '${querySnapshot2!.docs.length}' : '0',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          )
        ],
      ),
    );
  }
}
