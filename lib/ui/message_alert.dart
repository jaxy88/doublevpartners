import 'package:doublevpartners/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageAlert {
  static void messageAlert(String message) async {
    Get.snackbar(
      titleNotification,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
    );
  }
}
