// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

// Method to log in

addFov({
  required String name,
  required String image,
  required int point,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? number = prefs.get('phoneNumber') as String;
  CollectionReference favorite =
      FirebaseFirestore.instance.collection('favorite');

  await favorite
      .doc()
      .set({'name': name, 'image': image, 'point': point, 'number': number});
}

Future<void> removeFov({required name}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? number = prefs.getString('phoneNumber');

  if (number != null) {
    CollectionReference favorite =
        FirebaseFirestore.instance.collection('favorite');

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
