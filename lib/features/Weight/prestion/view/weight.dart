import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import 'package:origami/features/Weight/prestion/view_model/widget/Item_model.dart';

class Weight extends StatelessWidget {
  const Weight({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeightCubit()..GetData(),
      child: BlocConsumer<WeightCubit, WeightState>(
        builder: (context, state) {
          final Cubit = BlocProvider.of<WeightCubit>(context);

          return Scaffold(
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Container(
                width: double.infinity,
                height: 50.w,
                color: kPrimarycolor,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('${Cubit.sumall}'),
                    )
                  ],
                ),
              ),
            ),
            body: state is WeightLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: kPrimarycolor,
                    ),
                  )
                : state != WeightError
                    ? ListView.builder(
                        addAutomaticKeepAlives: false,
                        itemCount: Cubit.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, right: 10.w, top: 10.h),
                            child: Item_model_Khorda(
                                productname: Cubit.data[index].name!,
                                productpoints: Cubit.data[index].point!,
                                image: Cubit.data[index].Image!),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Error',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
