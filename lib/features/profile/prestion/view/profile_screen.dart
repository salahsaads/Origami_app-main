import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/Theme/constant.dart';
import 'package:origami/core/widgets/Item_Profile.dart';
import 'package:origami/core/widgets/custom_button.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';

import 'package:origami/features/profile/data/network.dart';
import 'package:origami/features/profile/prestion/view_model/profile_model.dart';

import '../../../../main.dart';
import '../../Cubit/cubit/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileCubit()..getdata(),
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          'assets/images/group-happy-friends-holding-cardboard-box-with-recycle-items.jpg'))),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final Cubit = BlocProvider.of<ProfileCubit>(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      state is ProfileLoaded
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Item_Profile(
                                  Title: '${Cubit.profileModel!.name}',
                                  iconname: Icons.person,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Item_Profile(
                                  Title: '${Cubit.profileModel!.number}',
                                  iconname: Icons.phone,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Item_Profile(
                                  Title: '${Cubit.profileModel!.location}',
                                  iconname: Icons.location_on,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/coin.png',
                                      width: 50.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      height: 40.h,
                                      width: 200.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: kSecondarycolor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        '${Cubit.profileModel!.point}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24.sp,
                                            fontFamily: kFontfamily,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: kPrimarycolor,
                              ),
                            ),

                      SizedBox(
                        height: 20.h,
                      ),

                      CustomButton(
                        text: 'تسجيل خروج',
                        ontap: () {
                          BlocProvider.of<AuthCubit>(context)
                              .logout(context: context);
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        )));
  }
}
