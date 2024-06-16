import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/widgets/custom_itrro_appbar.dart';

import '../../../../core/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(),
    );
  }
}

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomIntoAppbar(text: 'إنشاء حساب جديد'),
          SizedBox(
            height: 10.h,
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 100.w,
          ),
          const RegisterForm()
        ],
      ),
    );
  }
}
