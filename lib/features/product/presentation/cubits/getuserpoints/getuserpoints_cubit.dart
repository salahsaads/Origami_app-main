import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:origami/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'getuserpoints_state.dart';

class GetuserpointsCubit extends Cubit<GetuserpointsState> {
  GetuserpointsCubit() : super(GetuserpointsInitial());
  String? phoneNumber = pref.getString('phoneNumber');
  int? points;
  getPoints() async {
    List userdata = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    userdata.addAll(querySnapshot.docs);

    emit(Success(points: userdata[0]['points']));
    points = userdata[0]['points'];
  }
}
