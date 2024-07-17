import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Theme/constant.dart';

class CardModel extends StatefulWidget {
  const CardModel({
    super.key,
    required this.image,
    required this.productname,
    required this.productpoints,
  });
  final String image;
  final String productname;
  final int productpoints;

  @override
  State<CardModel> createState() => _CardModelState();
}

class _CardModelState extends State<CardModel> {
  bool add = false;
  bool? fev = false;
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fev = prefs.getBool(widget.productname);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBool();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (fev == true) {
          prefs.setBool(widget.productname, false);
          removeFov(
            name: widget.productname,
          );
          setState(() {
            fev = false;
            //delate;
          });
        } else if (fev == false || fev == null) {
          prefs.setBool(widget.productname, true);
          Add_Fov(
              name: widget.productname,
              Image: widget.image,
              point: widget.productpoints);

          setState(() {
            fev = true;
          });
        }
      },
      child: Container(
        // height: 200.h,
        // width: 150.w,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimarycolor, width: 0.2.w),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: kSecondarycolor,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.image))),
                  ),
                  Positioned(
                      right: 2,
                      top: 5,
                      child: fev != null
                          ? fev == true
                              ? Icon(
                                  Icons.favorite,
                                  size: 28,
                                  color: fev! ? Colors.red : null,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  size: 28,
                                  color: fev! ? Colors.red : null,
                                )
                          : Icon(
                              Icons.favorite_border,
                              size: 28,
                            ))
                ],
              ),
              SizedBox(
                height: 4.5.h,
              ),
              Text(
                widget.productname,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: kFontfamily,
                    fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "نقطه",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: kFontfamily,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimarycolor),
                  ),
                  Text(
                    "${widget.productpoints} ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: kFontfamily,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimarycolor),
                  ),
                  // Text(
                  //   "1 كيلو : ",
                  //   textDirection: TextDirection.rtl,
                  //   style: TextStyle(
                  //       fontFamily: kFontfamily,
                  //       fontSize: 14.sp,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kPrimarycolor),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var number = prefs.get('phoneNumber');
                    await FirebaseFirestore.instance
                        .collection('Product_In_Car')
                        .add({
                      'image': widget.image,
                      'productname': widget.productname,
                      'productpoints': widget.productpoints,
                      'user_number': number
                    });

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      headerAnimationLoop: true,
                      animType: AnimType.bottomSlide,
                      title: "تم الاضافه الي السله ",
                      titleTextStyle: TextStyle(
                          fontSize: 30.sp,
                          fontFamily: kFontfamily,
                          color: Colors.black),
                    ).show();
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      Text(
                        "  الاضافه الي السله ",
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontFamily: kFontfamily,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 24.sp,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
