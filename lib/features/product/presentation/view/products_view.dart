import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/product/presentation/cubits/get_categories_cubit/get_categories_cubit.dart';
import '../cubits/getuserpoints/getuserpoints_cubit.dart';
import 'widgets/Shimmwr_Loading.dart';
import 'widgets/category_products.dart';
import 'widgets/products_appbar.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool getdatacheck = false;
  List categoryName = [];
  getCategoriesName() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Product_Categories').get();

    categoryName.addAll(querySnapshot.docs);
    setState(() {
      getdatacheck = true;
    });
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
    return Scaffold(
      body: Column(children: [
        BlocProvider(
          create: (context) => GetuserpointsCubit()..getPoints(),
          child: BlocBuilder<GetuserpointsCubit, GetuserpointsState>(
              builder: (context, state) {
            int? points = BlocProvider.of<GetuserpointsCubit>(context).points;
            if (state is Success) {
              return Expanded(
                  flex: 4,
                  child: ProductAppBar(
                    point: points,
                  ));
            } else {
              return Expanded(
                  flex: 4,
                  child: ProductAppBar(
                    point: 0,
                  ));
            }
          }),
        ),
        getdatacheck
            ? Expanded(
                flex: 11,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 15.h),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: categoryName.length,
                    itemBuilder: (context, index) => Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
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
                          height: 15.h,
                        ),
                        BlocProvider(
                          create: (context) => GetCategoriesCubit()
                            ..getcategoryproduct('${categoryName[index].id}'),
                          child: const CategoryProducts(
                            dir: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            : const Expanded(flex: 11, child: ShimmerLoading()),
        SizedBox(
          height: 60.h,
        )
      ]),
    );
  }
}
