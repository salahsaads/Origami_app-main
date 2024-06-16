import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/Theme/constant.dart';

class CardModel extends StatelessWidget {
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
                  image: const DecorationImage(
                      image: AssetImage('assets/images/product.png'))),
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
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "اضافه الي السله",
                      style:
                          TextStyle(fontSize: 10.sp, fontFamily: kFontfamily),
                    ),
                    const Icon(Icons.shopping_cart)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
