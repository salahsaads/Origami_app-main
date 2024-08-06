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
                  height: MediaQuery.sizeOf(context).height / 3,
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
                    height: MediaQuery.sizeOf(context).height / 3 - 180,
                  ),
                  Center(
                      child: Image.asset(
                    widget.image,
                    width: 100.w,
                  )),
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height / 6 - 100,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Cairo-Regular',
                fontSize: 20.sp,
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
                fontSize: 15.sp,
                color: kPrimarycolor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Spacer(),
          Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: widget.ontap,
                child: Container(
                  width: 40.w,
                  height: 40.h,
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
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
