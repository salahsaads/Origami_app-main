import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';

import '../../models/card_model.dart';

class CategoryProducts extends StatefulWidget {
  CategoryProducts({
    super.key,
    required this.collectionpath,
    required this.dir,
  });

  final String collectionpath;
  Axis dir = Axis.horizontal;

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
  }

  @override
  void initState() {
    getcategoryproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GridView.builder(
        //reverse: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisCount: 1,
        ),
        itemCount: categoryProducts.length,
        scrollDirection: widget.dir,
        itemBuilder: (context, index) => CardModel(
          image: categoryProducts[index]['image'],
          productname: categoryProducts[index]['name'],
          productpoints: categoryProducts[index]['point'],
        ),
      ),
    );
  }
}
