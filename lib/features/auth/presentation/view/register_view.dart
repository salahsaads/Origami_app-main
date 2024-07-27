import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/core/widgets/custom_itrro_appbar.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';

import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          }
        },
        child: const Scaffold(
          body: RegisterBody(),
        ));
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
