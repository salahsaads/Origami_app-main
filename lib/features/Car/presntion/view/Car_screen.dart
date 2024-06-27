import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view_model/car_prodect_model.dart';

class Car_screen extends StatefulWidget {
  Car_screen({super.key, required this.number});
  var number;
  @override
  State<Car_screen> createState() => _Car_screenState();
}

class _Car_screenState extends State<Car_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 30.w),
          alignment: Alignment.center,
          width: double.infinity,
          height: 40.h,
          decoration: BoxDecoration(
              color: kPrimarycolor, borderRadius: BorderRadius.circular(15.r)),
          child: Text(
            'تواصل',
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: kFontfamily,
              color: kSecondarycolor,
            ),
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
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Product_In_Car')
                .where('user_number', isEqualTo: widget.number)
                .get(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snap.hasError) {
                return Center(child: Text('Error: ${snap.error}'));
              } else if (!snap.hasData || snap.data!.docs.isEmpty) {
                return Center(child: Text('No products found.'));
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 5,
                    crossAxisCount: 1,
                  ),
                  itemCount: snap.data!.docs.length,
                  itemBuilder: (context, index) {
                    var product =
                        snap.data!.docs[index].data() as Map<String, dynamic>;
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
