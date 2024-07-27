import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:origami/features/auth/logic/authentication.dart';
import 'package:origami/features/screens/loading_manger.dart';
import 'package:origami/features/auth/presentation/view/login_view.dart';

import '../../../../../core/Theme/constant.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController location_on = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool isloading = false;

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManger(
      isloading: isloading,
      child: Form(
        key: form,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(
                label: 'الاسم',
                hint: 'ادخل اسمك',
                icon: Icons.person,
                obscure: false,
                controller: name,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                obscure: false,
                label: 'رقم الهاتف ',
                hint: 'ادخل رقم هاتفك',
                icon: Icons.phone,
                controller: phone,
                keyboardType: TextInputType.phone,
                maxLength: 11,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                obscure: true,
                label: 'الباسورد',
                hint: 'ادخل كلمه المرور',
                icon: Icons.lock,
                controller: pass,
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextField(
                obscure: false,
                label: 'العنوان',
                hint: 'ادخل عنوانك',
                icon: Icons.location_on,
                controller: location_on,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                ontap: () async {
                  if (form.currentState!.validate()) {
                    isloading = true;
                    BlocProvider.of<AuthCubit>(context).register(
                      name: name.text.trim(),
                      phone: phone.text.trim(),
                      pass: pass.text.trim(),
                      location: location_on.text.trim(),
                      context: context,
                    );
                    isloading = false;
                  }
                },
                text: isloading ? 'Loading...' : 'إنشاء حساب',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                      },
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            color: kPrimarycolor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                  const Text(
                    "!لديك حساب بالفعل",
                    style: TextStyle(
                      fontFamily: 'NotoKufiArabic',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
