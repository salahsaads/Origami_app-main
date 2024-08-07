// ignore_for_file: library_private_types_in_public_api

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';

import 'package:origami/features/screens/loading_manger.dart';

import 'package:origami/features/auth/presentation/view/register_view.dart';

import '../../../../core/Theme/constant.dart';

import '../../../../core/widgets/custom_itrro_appbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: state.title,
              desc: state.message,
              btnOkOnPress: () {},
            ).show();
          } else if (state is AuthLoading) {
            isloading = true;
          }
        },
        child: Scaffold(
          body: LoadingManger(
            isloading: isloading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomIntoAppbar(
                    text: "مرحبا بك",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 50.w,
                  ),
                  Form(
                      key: formstate,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              label: 'رقم الهاتف',
                              hint: 'ادخل رقم هاتفك',
                              icon: Icons.phone,
                              controller: _phoneNumberController,
                              obscure: false,
                              keyboardType: TextInputType.number,
                              maxLength: 11,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextField(
                              obscure: true,
                              label: 'الباسورد',
                              hint: 'ادخل كلمه المرور',
                              icon: Icons.lock,
                              controller: _passwordController,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                              ontap: () async {
                                if (formstate.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      phone: _phoneNumberController,
                                      pass: _passwordController,
                                      context: context);
                                  // isloading = true;

                                  // login(
                                  //   phone: _phoneNumberController,
                                  //   pass: _passwordController,
                                  //   context: context,
                                  // );

                                  // setState(() {

                                  // });
                                }
                              },
                              text: 'تسجيل الدخول ',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      "إنشاء حساب جديد",
                                      style: TextStyle(
                                          color: kPrimarycolor,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    )),
                                const Text(
                                  "! ليس لديك حساب ",
                                  style: TextStyle(
                                    fontFamily: 'NotoKufiArabic',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
