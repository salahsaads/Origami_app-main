import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/features/Car/presntion/manger/shipping_card_cubit/shipping_card_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/Theme/constant.dart';

class CardModel2 extends StatefulWidget {
  const CardModel2({
    super.key,
    required this.image,
    required this.productname,
    required this.productpoints,
  });
  final String image;
  final String productname;
  final int productpoints;

  @override
  State<CardModel2> createState() => _CardModel2State();
}

class _CardModel2State extends State<CardModel2> {
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
    return BlocProvider(
      create: (context) => ShippingCardCubit(),
      child: BlocConsumer<ShippingCardCubit, ShippingCardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final Cubit = BlocProvider.of<ShippingCardCubit>(context);
          return Container(
            height: 200.w,
            width: 160.w,
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
                        height: 90.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: kSecondarycolor,
                            image: DecorationImage(
                                image: NetworkImage(widget.image))),
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
                  SizedBox(
                    height: 4.5.h,
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
                      Text(
                        "1 كيلو : ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontFamily: kFontfamily,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: kSecondarycolor),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Cubit.add();
                                DataGloble.Prodect.addAll(
                                    {'${widget.productname}': Cubit.x});
                                DataGloble.PointAll += widget.productpoints;
                              },
                              child: Icon(Icons.add)),
                          Text(
                            '${Cubit.x}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                              onTap: () {
                                Cubit.remove();
                                if (Cubit.x == 0) {
                                  DataGloble.Prodect.remove(widget.productname);
                                } else {
                                  DataGloble.Prodect.addAll(
                                      {'${widget.productname}': Cubit.x});
                                }

                                DataGloble.PointAll -= widget.productpoints;
                                print(DataGloble.PointAll);
                              },
                              child: Icon(Icons.remove))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.5.h,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimarycolor,
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var number = prefs.get('phoneNumber');
                        QuerySnapshot querySnapshot = await FirebaseFirestore
                            .instance
                            .collection('Product_In_Car')
                            .where('user_number', isEqualTo: number)
                            .where('productname', isEqualTo: widget.productname)
                            .get();

                        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
                          await doc.reference.delete();
                        }

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          headerAnimationLoop: true,
                          animType: AnimType.bottomSlide,
                          title: "تم الحذف من السله ",
                          titleTextStyle: TextStyle(
                              fontSize: 24.sp,
                              fontFamily: kFontfamily,
                              color: Colors.black),
                        ).show();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "الحذف من  السله",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: kFontfamily,
                              color: kSecondarycolor,
                            ),
                          ),
                          const Icon(
                            Icons.shopping_cart,
                            color: kSecondarycolor,
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
