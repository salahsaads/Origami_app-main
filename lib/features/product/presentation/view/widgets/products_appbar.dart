import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Car/presntion/view/Car_screen.dart';
import 'package:origami/features/product/presentation/view/widgets/shopping_cart.dart';
import 'package:origami/features/product/presentation/view/widgets/user_points.dart';
import 'package:origami/features/productsSearch/presentation/views/product_search_view.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';
import 'package:origami/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../profile/data/network.dart';

class ProductAppBar extends StatefulWidget {
  ProductAppBar({super.key, required this.point});
  int? point;

  @override
  State<ProductAppBar> createState() => _ProductAppBarState();
}

class _ProductAppBarState extends State<ProductAppBar> {
  List userdata = [];
  QuerySnapshot? querySnapshot2;

  String? userphone;
  Future<String> getuserPoints() async {
    userphone = pref.getString('phoneNumber');
    querySnapshot2 = await FirebaseFirestore.instance
        .collection('Product_In_Car')
        .where('user_number', isEqualTo: userphone)
        .get();

    setState(() {});
    return 'yes';
  }

  ProfileModel? profileModel;

  getdata() async {
    userphone = await pref.getString('phoneNumber');

    profileModel = await FirbaseGet.getData(userphone!);
    setState(() {});
  }

  @override
  void initState() {
    getuserPoints();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: kPrimarycolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 20),
          bottomRight: Radius.elliptical(300, 20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 20.h,
            // ),
            Row(
              children: [
                UserPoints(
                  point: widget.point,
                ),
                Spacer(),
                profileModel != null
                    ? Row(
                        children: [
                          Text(
                            " ${profileModel!.name}",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: kFontfamily,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '  مرحبا',
                            style: TextStyle(
                                fontSize: 15.sp, fontFamily: kFontfamily),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShoppingCart(
                    userphone: userphone,
                    points: 0,
                    querySnapshot2: querySnapshot2),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductsSearchView()));
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 90.w,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: kSecondarycolor,
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Text(
                          "ما الذي تبحث عنه؟",
                          style: TextStyle(
                              fontSize: 15.sp, fontFamily: kFontfamily),
                        ),
                        Icon(
                          Icons.search,
                          size: 30.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
