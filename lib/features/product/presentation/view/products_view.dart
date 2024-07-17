import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/AllProducts/all_products_view.dart';
import 'package:origami/features/product/presentation/cubits/getuserpoints/getuserpoints_cubit.dart';

import '../../../../core/widgets/category_products.dart';
import 'widgets/products_appbar.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late int points;
  List categoryName = [];
  getCategoriesName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Product_Categories').get();

    categoryName.addAll(querySnapshot.docs);
    setState(() {});
  }

  // getProducts() async {
  //   // FirebaseFirestore.instance.collection('Product_Categories').doc(categoryName)
  // }
  @override
  void initState() {
    getCategoriesName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => GetuserpointsCubit()..getPoints(),
          child: const ProductAppBar(),
        ),

        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
            ),
            itemCount: categoryName.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => AllProdoct(
                    //                 collectionpath:
                    //                     '${categoryName[index].id}')));
                    //   },
                    //   child: Text(' شاهد الكل ',
                    //       style: TextStyle(
                    //         fontSize: 20.sp,
                    //         height: 0.2,
                    //         color: kPrimarycolor,
                    //         fontFamily: kFontfamily,
                    //       )),
                    // ),

                    Text(categoryName[index]['Categoryname'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          height: 0.2,
                          fontFamily: kFontfamily,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CategoryProducts(
                  AspectRatio: 1.3,
                  dir: Axis.horizontal,
                  collectionpath: '${categoryName[index].id}',
                ),
              ],
            ),
          ),
        ))
        // CardModel(
        //   image: 'assets/images/product.png',
        //   productname: "الكاميرا",
        //   productpoints: 150,
        // )
      ],
    );
  }
}
