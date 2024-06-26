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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: const BoxDecoration(
                      color: kSecondarycolor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(200, 70),
                        bottomRight: Radius.elliptical(200, 70),
                      )),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                      child: Image.asset(
                    widget.image,
                    width: 300.w,
                  )),
                ],
              )
            ],
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontFamily: 'Cairo-Regular',
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
                height: 0.9),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 110.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 10.w,
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
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: kSecondarycolor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
