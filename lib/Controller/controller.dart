import 'package:farmwise_ai/DB_Handler/data_handler.dart';
import 'package:farmwise_ai/Model/DataModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Formcontroller extends GetxController {
  static Formcontroller get instance => Get.find();
  final name = TextEditingController();
  final gender = TextEditingController();
  final area = TextEditingController();
  final address = TextEditingController();
  final date = TextEditingController();
  final videoname = TextEditingController();
  final userRepo = Get.put(UserRepository());

  Future<void> setdata(Map<String, dynamic> data) async {
    await userRepo.addUser(data);
  }

  Future<List<DataModel>> getVideoData() async {
    return await userRepo.getdata();
  }
}
