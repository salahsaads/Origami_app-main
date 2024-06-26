import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/Theme/constant.dart';

class CardModel2 extends StatelessWidget {
  const CardModel2({
    super.key,
    required this.image,
    required this.productname,
    required this.productpoints,
  });
  final String image;
  final String productname;
  final int productpoints;
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
            Container(
              height: 90.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: kSecondarycolor,
                  image: DecorationImage(image: NetworkImage(image))),
            ),
            SizedBox(
              height: 4.5.h,
            ),
            Text(
              productname,
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
                  "$productpoints ",
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimarycolor,
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var number = prefs.get('phoneNumber');
                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('Product_In_Car')
                      .where('user_number', isEqualTo: number)
                      .where('productname', isEqualTo: productname)
                      .get();

                  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
                    await doc.reference.delete();
                  }

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    headerAnimationLoop: true,
                    animType: AnimType.bottomSlide,
                    title: "تم الحذف الي السله ",
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
                      "الحذف من  السله",
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
