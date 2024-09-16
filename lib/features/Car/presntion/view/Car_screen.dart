// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/core/utils/telecom_data.dart';
import 'package:origami/features/Car/presntion/view_model/car_prodect_model.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../Weight/prestion/view_model/widget/Shimmer_Loading_weight.dart';

class CarScreen extends StatefulWidget {
  CarScreen({super.key, required this.number, required this.allpoint});
  var number;
  double allpoint;
  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final int ProdectNumber = 0;
  // Replace with actual phone number

  void openWhatsApp(String phoneNumber) async {
    final String url = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(
      'السلام عليكم  اريد التواصل معكم لاستبدال منتجات ${DataGloble.Prodect} الاجمالي  ${DataGloble.PointAll} ❤️ ',
    )}';
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
    if (DataGloble.Prodect.isNotEmpty) {
      {
        DataGloble.Prodect.clear();
      }
    }
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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimarycolor,
          centerTitle: true,
          title: Icon(
            Icons.shopping_cart,
            size: 30.sp,
            color: kSecondarycolor,
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.allpoint >= DataGloble.PointAll &&
                        DataGloble.PointAll > 0) {
                      openWhatsApp(whatsapp);
                    } else if (DataGloble.PointAll == 0) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: true,
                        animType: AnimType.bottomSlide,
                        title: 'لا يوجد منتجات',
                        titleTextStyle: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: kFontfamily,
                            color: Colors.black),
                      ).show();
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
                    // width: 140.w,
                    height: 40.h,
                    decoration: const BoxDecoration(
                        color: kPrimarycolor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.allpoint >= DataGloble.PointAll &&
                        DataGloble.PointAll > 0) {
                      launchUrlString(call);
                    } else if (DataGloble.PointAll == 0) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: true,
                        animType: AnimType.bottomSlide,
                        title: 'لا يوجد منتجات',
                        titleTextStyle: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: kFontfamily,
                            color: Colors.black),
                      ).show();
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
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.allpoint >= DataGloble.PointAll &&
                        DataGloble.PointAll > 0) {
                      launchFacebookProfile();
                    } else if (DataGloble.PointAll == 0) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: true,
                        animType: AnimType.bottomSlide,
                        title: 'لا يوجد منتجات',
                        titleTextStyle: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: kFontfamily,
                            color: Colors.black),
                      ).show();
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
                    // width: 50.w,
                    height: 40.h,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: kPrimarycolor,
                    ),
                    child: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: SizedBox(
              height: MediaQuery.sizeOf(context).height - 200,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Product_In_Car')
                    .where('user_number', isEqualTo: widget.number)
                    .snapshots(), // Use snapshots() instead of get()
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
                        var product = snap.data!.docs[index].data();
                        return CardModel2(
                          image: product['image'],
                          productname: product['productname'],
                          productpoints: product['productpoints'],
                        );
                      },
                    );
                  }
                },
              )),
        ));
  }
}
