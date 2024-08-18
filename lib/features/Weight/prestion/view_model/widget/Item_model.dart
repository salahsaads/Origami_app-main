import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import '../../../../../core/Theme/constant.dart';

class Item_model_Khorda extends StatefulWidget {
  const Item_model_Khorda({
    super.key,
    required this.image,
    required this.productname,
    required this.productpoints,
  });
  final String image;
  final String productname;
  final int productpoints;

  @override
  State<Item_model_Khorda> createState() => _Item_model_KhordaState();
}

class _Item_model_KhordaState extends State<Item_model_Khorda> {
  var qu = 0.0;
  var sum = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (DataGloble.KProdect.length != 0) {
      DataGloble.KProdect.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Cubit = BlocProvider.of<WeightCubit>(context);

    return Container(
      height: 300.w,
      width: 160.w,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimarycolor, width: 0.2.w),
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 90.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: kSecondarycolor,
                  image: DecorationImage(image: NetworkImage(widget.image))),
            ),
            SizedBox(
              height: 4.5.h,
            ),
            Text(
              widget.productname,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: kFontfamily,
                  fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "نقطه",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                Text(
                  "${widget.productpoints} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                Text(
                  "1 كيلو : ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "كيلوا",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "${qu}",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: kPrimarycolor),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "الوزن المتاح: ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "   ${qu * widget.productpoints} ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      color: kPrimarycolor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  " النقط الكلي ",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "انقاص",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (qu != 0.0) {
                        qu -= .5;
                        Cubit.Sum_All2(widget.productpoints * 1.0);
                        DataGloble.KProdect.addAll(
                            {widget.productname: qu * widget.productpoints});
                      }
                      if (qu == 0) {
                        DataGloble.KProdect.remove(
                            {widget.productname: qu * widget.productpoints});
                      }
                    });
                  },
                  child: Container(
                    child: Icon(Icons.remove, size: 40.sp, color: Colors.white),
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: kPrimarycolor,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Text(
                  "اضافه",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: kFontfamily,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      qu += .5;
                      Cubit.Sum_All(widget.productpoints * 1.0);
                      DataGloble.KProdect.addAll(
                          {widget.productname: qu * widget.productpoints});
                    });
                  },
                  child: Container(
                    child: Icon(Icons.add, size: 40.sp, color: Colors.white),
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        color: kPrimarycolor,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
