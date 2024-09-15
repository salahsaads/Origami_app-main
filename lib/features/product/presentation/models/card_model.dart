import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/features/favoriteScreen/data/add_fav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Theme/constant.dart';

class CardModel extends StatefulWidget {
  const CardModel(
      {super.key,
      required this.image,
      required this.productname,
      required this.productpoints,
      required this.addornot,
      required this.details,
      this.isBottomSheet = false});
  final String image;
  final String productname;
  final int productpoints;
  final bool addornot;
  final String details;
  final bool? isBottomSheet;

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
      child: Container(
        // height: 200.h,
        // width: 150.w,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: kPrimarycolor, width: 0.2.w),
                right: BorderSide(color: kPrimarycolor, width: 0.2.w),
                left: BorderSide(color: kPrimarycolor, width: 0.2.w),
                bottom: BorderSide(color: kPrimarycolor, width: 0.2.w)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    height: widget.isBottomSheet == true ? 47.h : 150.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: kSecondarycolor,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.image))),
                  ),
                  Positioned(
                    right: 2,
                    child: GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

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
                          addFov(
                              name: widget.productname,
                              image: widget.image,
                              point: widget.productpoints);

                          setState(() {
                            fev = true;
                          });
                        }
                      },
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
                          : const Icon(
                              Icons.favorite_border,
                              size: 28,
                            ),
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 3.h,
              // ),
              widget.isBottomSheet == false
                  ? SizedBox(
                      height: 10.h,
                    )
                  : const Spacer(),
              Text(
                widget.productname,
                style: TextStyle(
                    fontSize: 20.sp,
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
              widget.addornot
                  ? CustomScreenDetails(
                      details: widget.details,
                    )
                  : Container(),

              const Spacer(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "  الاضافه الي السله ",
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontFamily: kFontfamily,
                            color: Colors.white),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20.sp,
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

class CustomScreenDetails extends StatelessWidget {
  const CustomScreenDetails({super.key, required this.details});
  final String details;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          child: Text(
            details,
            maxLines: 7,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: kFontfamily,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: kPrimarycolor,
                overflow: TextOverflow.ellipsis),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
