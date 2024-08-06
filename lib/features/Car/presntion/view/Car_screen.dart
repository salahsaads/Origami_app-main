// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view_model/car_prodect_model.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../Weight/prestion/view_model/widget/Shimmer_Loading_weight.dart';

class Car_screen extends StatefulWidget {
  Car_screen({super.key, required this.number, required this.allpoint});
  var number;
  double allpoint;
  @override
  State<Car_screen> createState() => _Car_screenState();
}

class _Car_screenState extends State<Car_screen> {
  final int ProdectNumber = 0;
  final String phoneNumber =
      '+20 114 071 0570'; // Replace with actual phone number

  void openWhatsApp() async {
    final String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent('  ❤️ ${DataGloble.PointAll} الاجمالي ${DataGloble.Prodect}  السلام عليكم  اريد التواصل معكم لاستبدال مونتجات ')}';
    print('Attempting to launch URL: $url');
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  num totalPoints = 0;

  @override
  void initState() {
    super.initState();
    _getTotalProductPoints();
    DataGloble.PointAll = 0;
    DataGloble.Prodect.clear();
  }

  Future<void> _getTotalProductPoints() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Product_In_Car')
          .where('user_number', isEqualTo: widget.number)
          .get();

      num sum = 0;
      querySnapshot.docs.forEach((doc) {
        sum += doc['productpoints']; // assuming 'productpoints' is an int
      });

      setState(() {
        totalPoints = sum;
      });
    } catch (e) {
      print('Error fetching product points: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.allpoint >= DataGloble.PointAll &&
                      DataGloble.PointAll > 0) {
                    openWhatsApp();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      headerAnimationLoop: true,
                      animType: AnimType.bottomSlide,
                      title:
                          'لا يوجد نقاط كافيه بحاجه الي ${DataGloble.PointAll - widget.allpoint}',
                      titleTextStyle: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: kFontfamily,
                          color: Colors.black),
                    ).show();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: kPrimarycolor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Text(
                        'تواصل',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: kFontfamily,
                          color: kSecondarycolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (widget.allpoint >= DataGloble.PointAll &&
                      DataGloble.PointAll > 0) {
                    launchUrlString("tel://01063012453");
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      headerAnimationLoop: true,
                      animType: AnimType.bottomSlide,
                      title:
                          'لا يوجد نقاط كافيه بحاجه الي ${DataGloble.PointAll - widget.allpoint}',
                      titleTextStyle: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: kFontfamily,
                          color: Colors.black),
                    ).show();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimarycolor),
                      color: kSecondarycolor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: kPrimarycolor,
          centerTitle: true,
          title: Icon(
            Icons.shopping_cart,
            size: 30.sp,
            color: kSecondarycolor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 16),
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height - 200,
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Product_In_Car')
                    .where('user_number', isEqualTo: widget.number)
                    .get(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return ShimmerLoadingWeight();
                  } else if (snap.hasError) {
                    return Center(child: Text('Error: ${snap.error}'));
                  } else if (!snap.hasData || snap.data!.docs.isEmpty) {
                    return Center(child: Text('No products found.'));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.14,
                        mainAxisSpacing: 5,
                        crossAxisCount: 1,
                      ),
                      itemCount: snap.data!.docs.length,
                      itemBuilder: (context, index) {
                        var product = snap.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return CardModel2(
                          image: product['image'],
                          productname: product[
                              'productname'], // Assuming the field is named 'productname'
                          productpoints: product[
                              'productpoints'], // Assuming the field is named 'productpoints'
                        );
                      },
                    );
                  }
                },
              )),
        ));
  }
}
