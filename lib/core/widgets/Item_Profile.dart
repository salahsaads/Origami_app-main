import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';

class Item_Profile extends StatelessWidget {
  const Item_Profile({
    super.key,
    required this.Title,
    required this.iconname,
  });

  final String Title;
  final IconData iconname;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconname,
          size: 40.sp,
          color: kPrimarycolor,
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          height: 40.h,
          width: 200.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: kSecondarycolor, borderRadius: BorderRadius.circular(10)),
          child: Text(
            '${Title}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontFamily: kFontfamily,
                fontWeight: FontWeight.w800),
          ),
        )
      ],
    );
  }
}
