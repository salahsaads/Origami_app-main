import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/Theme/constant.dart';

class Intro extends StatefulWidget {
  const Intro({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.ontap,
  });
  final String image;
  final String title;
  final String subtitle;
  final Function()? ontap;

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 2,
            decoration: const BoxDecoration(
                color: kSecondarycolor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(200, 70),
                  bottomRight: Radius.elliptical(200, 70),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                    child: Image.asset(
                  widget.image,
                  height: MediaQuery.sizeOf(context).height / 2.5,
                )),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 14,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo-Regular',
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
                height: 0.7.h),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 20.sp,
                color: kPrimarycolor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              GestureDetector(
                onTap: widget.ontap,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    color: kPrimarycolor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 20.sp,
                      color: kSecondarycolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
