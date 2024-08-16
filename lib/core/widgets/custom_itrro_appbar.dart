import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/constant.dart';

class CustomIntoAppbar extends StatelessWidget {
  const CustomIntoAppbar({
    super.key,
    required this.text,
  });
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 7,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: kPrimarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 20),
          bottomRight: Radius.elliptical(300, 20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 17,
          ),
          Text(
            text!,
            style: TextStyle(
                fontSize: 28.sp,
                color: kSecondarycolor,
                fontFamily: 'NotoKufiArabic',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 100,
          ),
        ],
      ),
    );
  }
}
