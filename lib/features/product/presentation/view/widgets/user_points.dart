import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';

import '../../cubits/getuserpoints/getuserpoints_cubit.dart';

class UserPoints extends StatelessWidget {
  UserPoints({super.key, required this.point});
  int? point;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: kSecondarycolor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${point}",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: kFontfamily,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset(
            'assets/images/coin.png',
            width: 20.w,
          ),
        ],
      ),
    );
  }
}
