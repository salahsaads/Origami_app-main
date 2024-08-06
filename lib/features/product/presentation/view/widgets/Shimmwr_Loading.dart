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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10.h),
            // Shimmer for Title/Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 300.w,
                    height: 200,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300.w,
                    height: 200,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 300.w,
                    height: 200,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300.w,
                    height: 200,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            // Add more shimmer containers if necessary to match your UI
          ],
        ),
      ),
    );
  }
}
