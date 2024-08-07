// ignore_for_file: unnecessary_type_check

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:origami/bussinus_logic/authentiacation/authentication.dart';
import 'package:origami/features/Nav/prestion/view/nav_bar.dart';
import 'package:origami/features/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:origami/features/auth/presentation/view/login_view.dart';

import 'package:origami/features/onboarding/onboarding_view.dart';
import 'package:origami/features/register/prestion/view/register_screen.dart';
import 'package:origami/features/screens/splah_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Origami(), // Wrap your app
      ),
    );
  });
}

class Origami extends StatelessWidget {
  const Origami({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: Size(360, 690),
      child: CustomMaterialApp(),
    );
  }
}

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: Builder(builder: (context) {
            return SplashScreen(
              nextScreen: FutureBuilder<bool>(
                  future: checkLoginStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator or splash screen while checking login status
                      return const CircularProgressIndicator();
                    } else {
                      if (snapshot.hasError) {
                        // Handle error
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Navigate to home or login screen based on login status
                        return snapshot.data == true
                            ? const HomeScreen()
                            : OnBoardingView();
                      }
                    }
                  }),
              routes: {
                'loginpage': (context) => const LoginScreen(),
                'registerpage': (context) => const RegisterScreen(),
                'homepage': (context) => const HomeScreen(),
              },
            );
          })),
    );
  }
}
