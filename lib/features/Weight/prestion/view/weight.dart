import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/features/Weight/cubit/cubit/weight_cubit.dart';
import 'package:origami/features/Weight/prestion/view_model/widget/Item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Weight extends StatelessWidget {
  const Weight({super.key});
  final String phoneNumber =
      '+20 114 071 0570'; // Replace with actual phone number

  void openWhatsApp() async {
    final String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent('  ❤️  السلام عليكم  اريد التواصل معكم لاستبدال خورده ')}';
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
  }

  void _launchMessenger() async {
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
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Container(
                width: double.infinity,
                height: 80.w,
                color: Color(0xfffef7ff),
                child: Row(
                  children: [
                    //point all
                    Padding(
                      padding: EdgeInsets.only(left: 55.w),
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 45,
                        child: Text(
                          '${Cubit.sumall}',
                          style: TextStyle(fontSize: 20),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    //whatsapp
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: GestureDetector(
                        onTap: () {
                          openWhatsApp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 45,
                          child: FaIcon(FontAwesomeIcons.whatsapp),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                    //messenger
                    ,
                    Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: GestureDetector(
                        onTap: () {
                          _launchMessenger();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 45,
                          child: Icon(Icons.facebook),
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
