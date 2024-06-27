import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';

import '../../../../core/widgets/category_products.dart';
import '../../../../core/widgets/products_appbar.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
        const ProductAppBar(),

        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3,
            ),
            itemCount: categoryName.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(categoryName[index]['Categoryname'],
                    style: TextStyle(
                      fontSize: 20.sp,
                      height: 0.2,
                      fontFamily: kFontfamily,
                    )),
                SizedBox(
                  height: 15.h,
                ),
                CategoryProducts(
                  collectionpath: '${categoryName[index].id}',
                )
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
