import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/product/presentation/cubits/getuserpoints/getuserpoints_cubit.dart';

class UserPoints extends StatelessWidget {
  const UserPoints({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: kSecondarycolor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "نقطه",
            style: TextStyle(fontFamily: kFontfamily, fontSize: 18.sp),
          ),
          BlocBuilder<GetuserpointsCubit, GetuserpointsState>(
            builder: (context, state) {
              if (state is Success) {
                return Text(
                  "${state.points}",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: kFontfamily,
                  ),
                );
              }
              return Text(
                "${0}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: kFontfamily,
                ),
              );
              ;
            },
          ),
          Image.asset(
            'assets/images/coin.png',
            width: 25.w,
          ),
        ],
      ),
    );
  }
}
