import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/DataGloble/DataGloble.dart';
import 'package:origami/core/utils/telecom_data.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import 'package:origami/features/Weight/prestion/view_model/widget/Item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/Theme/constant.dart';
import '../view_model/widget/Shimmer_Loading_weight.dart';

class Weight extends StatelessWidget {
  const Weight({super.key});
// Replace with actual phone number

  Future<void> _launchFacebookProfile() async {
    const facebookProfileUrl = facebook;
    if (await canLaunchUrl(Uri.parse(facebookProfileUrl))) {
      await launchUrl(Uri.parse(facebookProfileUrl));
    } else {
      throw 'Could not launch $facebookProfileUrl';
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
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: MediaQuery.of(context).size.height * 0.115,
              ),
              child: GestureDetector(
                onTap: () {
                  WoltModalSheet.show<void>(
                    // pageIndexNotifier: pageIndexNotifier,
                    context: context,
                    pageListBuilder: (modalSheetContext) {
                      return [
                        WoltModalSheetPage(
                          backgroundColor: Colors.white,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Container(
                                    width: double.infinity,
                                    height: 60.w,
                                    color: Color(0xfffef7ff),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            decoration: BoxDecoration(
                                                color: kPrimarycolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        //whatsapp
                                        GestureDetector(
                                          onTap: () async {
                                            final String url =
                                                'https://wa.me/$whatsapp?text=${Uri.encodeComponent('  ❤️${Cubit.sumall} الاجمالي ${DataGloble.KProdect}  السلام عليكم  اريد التواصل معكم لاستبدال خورده ')}';
                                            print(
                                                'Attempting to launch URL: $url');
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
                                            child: FaIcon(
                                                FontAwesomeIcons.whatsapp),
                                            decoration: BoxDecoration(
                                                color: kPrimarycolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        // phone
                                        GestureDetector(
                                          onTap: () {
                                            _launchFacebookProfile();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            height: 45,
                                            child: Icon(Icons.facebook),
                                            decoration: BoxDecoration(
                                                color: kPrimarycolor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              launchUrlString(call);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 70,
                                              height: 45,
                                              child: Icon(Icons.phone),
                                              decoration: BoxDecoration(
                                                  color: kPrimarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  // width: 140.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimarycolor),
                    color: kSecondarycolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'تواصل',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: kFontfamily,
                          color: kPrimarycolor,
                        ),
                      ),
                    ],
                  ),
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
                    : const Center(
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



/** */