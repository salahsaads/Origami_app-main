import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import 'package:origami/features/Weight/prestion/view_model/widget/Item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../view_model/widget/Shimmer_Loading_weight.dart';

class Weight extends StatelessWidget {
  const Weight({super.key});
  final String phoneNumber =
      '+20 114 071 0570'; // Replace with actual phone number

  Future<void> _launchMessenger() async {
    const messengerUrl = 'http://ms.me/1Calmcalm';
    if (await canLaunch(messengerUrl)) {
      await launch(messengerUrl);
    } else {
      throw 'Could not launch $messengerUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeightCubit()..GetData(),
      child: BlocConsumer<WeightCubit, WeightState>(
        builder: (context, state) {
          final Cubit = BlocProvider.of<WeightCubit>(context);

          return Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: Container(
                width: double.infinity,
                height: 80.w,
                color: Color(0xfffef7ff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //point all
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 45,
                        child: Text(
                          '${Cubit.sumall}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    //whatsapp
                    GestureDetector(
                      onTap: () async {
                        final String url =
                            'https://wa.me/$phoneNumber?text=${Uri.encodeComponent('  ❤️${Cubit.sumall} الاجمالي ${DataGloble.KProdect}  السلام عليكم  اريد التواصل معكم لاستبدال خورده ')}';
                        print('Attempting to launch URL: $url');
                        try {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            print('Could not launch $url');
                            throw 'Could not launch $url';
                          }
                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 45,
                        child: FaIcon(FontAwesomeIcons.whatsapp),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    // phone
                    GestureDetector(
                      onTap: () {
                        _launchMessenger();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 45,
                        child: Icon(Icons.facebook),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          launchUrlString("tel://01063012453");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 70,
                          height: 45,
                          child: Icon(Icons.phone),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: state is WeightLoading
                ? ShimmerLoadingWeight()
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
