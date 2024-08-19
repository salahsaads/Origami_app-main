import 'package:flutter/material.dart';
import 'package:origami/features/product/presentation/models/card_model.dart';

Future showMaterialModalBottomSheet(
    {required List<dynamic> categoryProducts,
    required int index,
    required BuildContext context}) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SafeArea(
        child: CardModel(
          details: categoryProducts[index]['details'],
          addornot: true,
          image: categoryProducts[index]['image'],
          productname: categoryProducts[index]['name'],
          productpoints: categoryProducts[index]['point'],
        ),
      ),
    ),
  );
}
