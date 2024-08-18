import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:origami/features/product/presentation/cubits/get_categories_cubit/get_categories_cubit.dart';

import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../models/card_model.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({
    super.key,
    required this.dir,
  });

  final Axis dir;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
        builder: (context, state) {
          if (state is GetCategoriesLoaded) {
            List<dynamic> categoryProducts = state.categoryProducts;
            return GridView.builder(
              //reverse: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisCount: 1,
              ),
              itemCount: categoryProducts.length,
              scrollDirection: widget.dir,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CardModel(
                        details: categoryProducts[index]['details'],
                        addornot: true,
                        image: categoryProducts[index]['image'],
                        productname: categoryProducts[index]['name'],
                        productpoints: categoryProducts[index]['point'],
                      ),
                    ),
                  );
                },
                child: CardModel(
                  details: categoryProducts[index]['details'],
                  addornot: false,
                  image: categoryProducts[index]['image'],
                  productname: categoryProducts[index]['name'],
                  productpoints: categoryProducts[index]['point'],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
