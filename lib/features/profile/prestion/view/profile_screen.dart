import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/core/widgets/Item_Profile.dart';
import 'package:origami/core/widgets/custom_button.dart';
import 'package:origami/features/profile/data/network.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel? profileModel;
  getdata() async {
    profileModel = await FirbaseGet.GetData('01063012453');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: profileModel != null
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/vecteezy_3d-rendering-green-recycle-sign-with-globe-on-background_22715810.jpg'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image User or Icone app
                        SizedBox(
                          height: 150.h,
                        ),
                        // Container(
                        //     width: 100.w,
                        //     child: Image.asset(
                        //       'assets/images/logo.png',
                        //     )),
                        // SizedBox(
                        //   height: 40.h,
                        // ),
                        Item_Profile(
                          Title: '${profileModel!.name}',
                          iconname: Icons.person,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        Item_Profile(
                          Title: '${profileModel!.number}',
                          iconname: Icons.phone,
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        Item_Profile(
                          Title: '${profileModel!.location}',
                          iconname: Icons.location_on,
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        Row(
                          children: [
                            Image.asset(
                              'assets/images/coin.png',
                              width: 25.w,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '${profileModel!.point}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontFamily: kFontfamily,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        CustomButton(
                          text: 'تسجيل خروج',
                          ontap: () {
                            logout(context: context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/vecteezy_3d-rendering-green-recycle-sign-with-globe-on-background_22715810.jpg'))),
                  ),
                  const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                ],
              ));
  }
}
