// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:origami/features/login/presation/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/Nav/prestion/view/nav_bar.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

// Method to log in
Future<void> login({
  required TextEditingController phone,
  required TextEditingController pass,
  required BuildContext context,
}) async {
  // Perform login logic here

  // Check if phone number exists in Firestore
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('phoneNumber', isEqualTo: phone.text)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    // User with given phone number exists, now check password
    DocumentSnapshot userSnapshot = querySnapshot.docs.first;
    String storedPassword = userSnapshot['password'];

    if (storedPassword == pass.text) {
      // Password is correct, set login status to true and navigate to home screen
      await setLoginStatus(true);
      print("Login successful!");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('phoneNumber', phone.text);
      print(prefs.getString('phoneNumber'));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     ));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
      // Navigate to home screen or any other authenticated screen
    } else {
      // Password is incorrect
      print("Incorrect password!");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'خطأ بالباسورد',
        desc: ' بالرجاء التأكد من صحه البيانات المدخله واعاده المحاوله ',
        btnOkOnPress: () {},
      ).show();
    }
  } else {
    // User with given phone number does not exist
    print("User not found!");
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'المستخدم غير موجود',
      desc: ' بالرجاء التأكد من صحه البيانات المدخله واعاده المحاوله ',
      btnOkOnPress: () {},
    ).show();
  }
}

register(
    {required TextEditingController name,
    required TextEditingController phone,
    required TextEditingController pass,
    required TextEditingController location_on,
    required BuildContext context}) async {
  await users.doc(phone.text.trim()).set({
    'name': name.text.trim(),
    'phoneNumber': phone.text.trim(),
    'password': pass.text.trim(),
    'points': 0,
    'location': location_on.text.trim()
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('phoneNumber', phone.text);
  setLoginStatus(true);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false);
}

Add_Fov({
  required String name,
  required String Image,
  required int point,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? number = prefs.get('phoneNumber') as String;
  CollectionReference favorite =
      FirebaseFirestore.instance.collection('favorite');

  await favorite
      .doc()
      .set({'name': name, 'image': Image, 'point': point, 'number': number});
}



Future<void> removeFov({required name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? number = prefs.getString('phoneNumber');

  if (number != null ) {
    CollectionReference favorite = FirebaseFirestore.instance.collection('favorite');
    
    // Query for documents that match both 'name' and 'number'
    QuerySnapshot querySnapshot = await favorite
      .where('number', isEqualTo: number)
      .where('name', isEqualTo: name)
      .get();

    // Loop through the results and delete each document
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Favorite(s) removed successfully.');
  } else {
    if (number == null) {
      print("Phone number not found in SharedPreferences.");
    }
    
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

// Function to store login status locally
//
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
