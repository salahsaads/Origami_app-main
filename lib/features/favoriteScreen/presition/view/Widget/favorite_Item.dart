import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../bussinus_logic/authentiacation/authentication.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem(
      {super.key,
      required this.name,
      required this.image,
      required this.point});
  final String name;
  final String image;
  final int point;
  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,
      width: 160.w,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimarycolor, width: 0.2.w),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: kSecondarycolor,
                      image:
                          DecorationImage(image: NetworkImage(widget.image))),
                ),
                Positioned(
                    right: 2,
                    top: 5,
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setBool(widget.name, false);
                        removeFov(
                          name: widget.name,
                        );
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 4.5.h,
            ),
            Text(
              '${widget.name}',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: kFontfamily,
                  fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 4.5.h,
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
                  "${widget.point} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
              ],
            ),
            SizedBox(
              height: 4.5.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimarycolor,
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var number = prefs.get('phoneNumber');
                  await FirebaseFirestore.instance
                      .collection('Product_In_Car')
                      .add({
                    'image': widget.image,
                    'productname': widget.name,
                    'productpoints': widget.point,
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
                      'الاضافه الي السله',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: kFontfamily,
                        color: kSecondarycolor,
                      ),
                    ),
                    const Icon(
                      Icons.shopping_cart,
                      color: kSecondarycolor,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
