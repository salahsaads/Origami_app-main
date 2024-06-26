import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/Theme/constant.dart';

class CardModel extends StatefulWidget {
  const CardModel({
    super.key,
    required this.image,
    required this.productname,
    required this.productpoints,
  });
  final String image;
  final String productname;
  final int productpoints;

  @override
  State<CardModel> createState() => _CardModelState();
}

class _CardModelState extends State<CardModel> {
  bool add = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,
      width: 150.w,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimarycolor, width: 0.2.w),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 80.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: kSecondarycolor,
                  image: const DecorationImage(
                      image: AssetImage('assets/images/product.png'))),
            ),
            SizedBox(
              height: 4.5.h,
            ),
            Text(
              widget.productname,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: kFontfamily,
                  fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "نقطه",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                Text(
                  "${widget.productpoints} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                Text(
                  "1 كيلو : ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimarycolor),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var number = prefs.get('phoneNumber');
                  await FirebaseFirestore.instance
                      .collection('Product_In_Car')
                      .add({
                    'image': widget.image,
                    'productname': widget.productname,
                    'productpoints': widget.productpoints,
                    'user_number': number
                  });

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    headerAnimationLoop: true,
                    animType: AnimType.bottomSlide,
                    title: "تم الاضافه الي السله ",
                    titleTextStyle: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: kFontfamily,
                        color: Colors.black),
                  ).show();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "  الاضافه الي السله ",
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontFamily: kFontfamily,
                          color: Colors.white),
                    ),
                    const Icon(Icons.shopping_cart, color: Colors.white)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
