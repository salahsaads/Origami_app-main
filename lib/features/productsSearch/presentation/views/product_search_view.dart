import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/features/productsSearch/cubits/productsearch/productsearch_cubit.dart';
import 'package:origami/features/productsSearch/presentation/views/widget/product_search_delegate.dart';

import '../../../../core/Theme/constant.dart';

class ProductsSearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondarycolor,
          title: Text('Products'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearchDelegate());
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductsearchCubit, ProductsearchState>(
          builder: (context, state) {
            // Default state, you can show all products or a welcome screen
            return Center(
                child: Text(
              'Search for products',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                height: 0.2,
                fontFamily: kFontfamily,
              ),
            ));
          },
        ),
      ),
    );
  }
}
