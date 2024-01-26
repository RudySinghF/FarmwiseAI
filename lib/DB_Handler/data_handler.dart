import 'package:farmwise_ai/Model/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> user) async {
    await _db
        .collection("User")
        .add(user)
        .whenComplete(() => Get.snackbar("Success", "Submitted",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor:
                Color.fromARGB(255, 130, 216, 133).withOpacity(0.1),
            colorText: Color.fromARGB(255, 22, 141, 26)))
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 244, 121, 113).withOpacity(0.1),
          colorText: Color.fromARGB(255, 164, 23, 23));
      print(error.toString());
    });
  }

  Future<List<DataModel>> getdata() async {
    final snapshot = await _db.collection("User").get();
    final data = snapshot.docs.map((e) => DataModel.fromSnapshot(e)).toList();
    return data;
  }
}
