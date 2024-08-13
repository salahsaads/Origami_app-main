import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10.h), // Responsive height
            Padding(
              padding: EdgeInsets.all(8.0.r), // Responsive padding
              child: Container(
                width: 150.w, // Responsive width
                height: 20.h, // Responsive height
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                children: [
                  Container(
                    width: 300.w,
                    height: 200.h, // Responsive height
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 20.w), // Responsive width
                  Container(
                    width: 300.w,
                    height: 200.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Container(
                width: 150.w,
                height: 20.h,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                children: [
                  Container(
                    width: 300.w,
                    height: 200.h,
                    color: Colors.grey[300],
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 300.w,
                    height: 200.h,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
