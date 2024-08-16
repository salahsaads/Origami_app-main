import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.ontap,
  });
  final String text;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        // height: 45.h,
        height: MediaQuery.sizeOf(context).height / 15,
        decoration: BoxDecoration(
            color: kPrimarycolor,
            borderRadius: BorderRadius.circular(
              10.r,
            )),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'NotoKufiArabic',
              fontWeight: FontWeight.bold,
              color: kSecondarycolor),
        )),
      ),
    );
  }
}
