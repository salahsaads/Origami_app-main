// ignore_for_file: use_build_context_synchronously
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:origami/features/Nav/prestion/view/nav_bar.dart';
import 'package:origami/features/auth/logic/encyption.dart';
import 'package:origami/features/auth/presentation/view/login_view.dart';

import 'package:origami/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool t = false;
  void changeIcon() {
    if (t == false) {
      t = true;
    } else {
      t = false;
    }
    emit(AuthInitial());
  }

  Encryption encryptData = Encryption();
  Future<void> login({
    required TextEditingController phone,
    required TextEditingController pass,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phone.text.trim())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        String storedPassword = userSnapshot['password'];

        if (encryptData.decryptPassword(storedPassword).toString() ==
            pass.text.trim()) {
          await setLoginStatus(true);
          await pref.setString('phoneNumber', phone.text.trim());
          emit(AuthSuccess());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          emit(AuthError("خطأ بالباسورد",
              "بالرجاء التأكد من صحه البيانات المدخله واعاده المحاوله"));
        }
      } else {
        emit(AuthError("المستخدم غير موجود",
            "بالرجاء التأكد من صحه البيانات المدخله واعاده المحاوله"));
      }
    } catch (e) {
      emit(AuthError("خطأ غير متوقع", e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String phone,
    required String pass,
    required String location,
    required BuildContext context,
  }) async {
    // Regex pattern for a strong password
    final strongPasswordPattern = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    // Check if the password is strong
    if (!strongPasswordPattern.hasMatch(pass.trim())) {
      emit(AuthError("كلمة المرور ضعيفة",
          "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، منها حرف كبير، حرف صغير، رقم ورمز خاص."));
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(phone.trim())
          .set({
        'name': name.trim(),
        'phoneNumber': phone.trim(),
        'password': encryptData.encryptPassword(pass.trim()),
        'points': 0,
        'location': location.trim(),
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneNumber', phone);
      await setLoginStatus(true);
      emit(AuthSuccess());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } catch (e) {
      emit(AuthError("خطأ غير متوقع", e.toString()));
    }
  }

  logout({required BuildContext context}) async {
    setLoginStatus(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs
        .setString('phoneNumber', '')
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false));
  }

  Future<void> setLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

// }
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loginstate = prefs.getBool('isLoggedIn') ??
        false; // Default to false if value is not found

    return loginstate;
  }
}
