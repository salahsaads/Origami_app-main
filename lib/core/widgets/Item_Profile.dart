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
          size: 20.sp,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          '${Title}',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontFamily: kFontfamily,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
