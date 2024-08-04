import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view/Car_screen.dart';
import 'package:origami/features/product/presentation/cubits/getuserpoints_cubit/getuserpoints_cubit.dart';
import 'package:origami/features/product/presentation/view/widgets/shopping_cart.dart';
import 'package:origami/features/product/presentation/view/widgets/user_points.dart';
import 'package:origami/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAppBar extends StatefulWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar> {
  List userdata = [];
  QuerySnapshot? querySnapshot2;

  String? userphone;
  Future<String> getuserPoints() async {
    userphone = pref.getString('phoneNumber');
    querySnapshot2 = await FirebaseFirestore.instance
        .collection('Product_In_Car')
        .where('user_number', isEqualTo: '01063012453')
        .get();

    return 'yes';
  }

  @override
  void initState() {
    getuserPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: kPrimarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 20),
          bottomRight: Radius.elliptical(300, 20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.h,
            ),
            const UserPoints(),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShoppingCart(
                    userphone: userphone,
                    points: 0,
                    querySnapshot2: querySnapshot2),
                Container(
                  width: MediaQuery.sizeOf(context).width - 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: kSecondarycolor,
                  ),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        "ما الذي تبحث عنه؟",
                        style:
                            TextStyle(fontSize: 15.sp, fontFamily: kFontfamily),
                      ),
                      Icon(
                        Icons.search,
                        size: 30.sp,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
