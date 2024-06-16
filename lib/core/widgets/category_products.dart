import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/prodect/prestion/view_model/Models/card_model.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({
    super.key,
    required this.collectionpath,
  });

  final String collectionpath;
  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  List categoryProducts = [];
  getcategoryproduct() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Product_Categories')
        .doc(widget.collectionpath)
        .collection('products')
        .get();
    categoryProducts.addAll(querySnapshot.docs);
    setState(() {});
    // print(categoryProducts.toString());
  }

  @override
  void initState() {
    getcategoryproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.4,
          mainAxisSpacing: 5,
          crossAxisCount: 1,
        ),
        itemCount: categoryProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CardModel(
          image: 'assets/images/product.png',
          productname: categoryProducts[index]['name'],
          productpoints: 150,
        ),
      ),
    );
  }
}
