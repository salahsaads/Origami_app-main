import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/productsSearch/cubits/productsearch/productsearch_cubit.dart';

import '../../../../product/presentation/models/card_model.dart';

class ProductSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<ProductsearchCubit>().searchProducts(query);
    }

    return BlocBuilder<ProductsearchCubit, ProductsearchState>(
      builder: (context, state) {
        if (state is ProductsLoading) {
          return Center(child: CircularProgressIndicator(color: kPrimarycolor));
        } else if (state is ProductsLoaded) {
          if (state.products.isEmpty) {
            return Center(
                child: Text(
              'No products found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                height: 0.2,
                fontFamily: kFontfamily,
              ),
            ));
          }

          return ListView(
            children: state.products.entries.map((entry) {
              return Container(
                color: kPrimarycolor,
                child: ExpansionTile(
                  title: Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      fontFamily: kFontfamily,
                    ),
                  ), // Category name
                  children: entry.value.map((product) {
                    return GestureDetector(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: CardModel(
                              details: product['details'],
                              addornot: true,
                              image: product['image'],
                              productname: product['name'],
                              productpoints: product['point'],
                            ),
                          ),
                        );

                        // print(
                        //     '${product['name']}======================================================================');
                        // showMaterialModalBottomSheet(
                        //   context: context,
                        //   builder: (context) => Container(
                        //     constraints: BoxConstraints(
                        //       maxHeight: MediaQuery.of(context).size.height *
                        //           0.5, // Example constraint
                        //     ),
                        //     child: Expanded(
                        //       child: Column(
                        //         children: [
                        //           CardModel(
                        //             details: product['details'],
                        //             addornot: true,
                        //             image: product['image'],
                        //             productname: product['name'],
                        //             productpoints: product['point'],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                        // // WoltModalSheet.show<void>(
                        // //   // pageIndexNotifier: pageIndexNotifier,
                        // //   context: context,
                        // //   pageListBuilder: (modalSheetContext) {
                        // //     return [
                        // //       WoltModalSheetPage(
                        // //         backgroundColor: Colors.white,
                        // //         child:
                        // //       ),
                        // //     ];
                        // //   },
                        // // );
                      },
                      child: Container(
                        decoration: BoxDecoration(color: kSecondarycolor),
                        child: ListTile(
                          title: Text(
                            product['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: kPrimarycolor,
                              fontFamily: kFontfamily,
                            ),
                          ),
                          // subtitle: Text('Price: ${product['price']}'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        } else if (state is ProductsError) {
          return Center(
              child: Text(
            'Error: ${state.message}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              height: 0.2,
              fontFamily: kFontfamily,
            ),
          ));
        }

        return Center(
            child: Text(
          'Type to search for products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            height: 0.2,
            fontFamily: kFontfamily,
          ),
        ));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
