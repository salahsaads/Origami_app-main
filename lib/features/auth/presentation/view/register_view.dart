import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origami/core/widgets/custom_itrro_appbar.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';

import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomIntoAppbar(text: 'إنشاء حساب جديد'),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 4,
            ),
            const RegisterForm()
          ],
        ),
      )),
    );
  }
}
