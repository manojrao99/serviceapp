import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../stayles.dart';

class FlutterToastUtil {
  static Future<void> showErrorToast(String message) async {
    await showErrorDialog(message);
  }

  static Future<void> showSuccessToast(String message) async {
    await showSuccessDialog(message);
  }

  static Future<void> showSuccessDialog(String message) async {
    await Get.defaultDialog(
        title: "Cultyvate",
        middleText: message,
        backgroundColor: cultGreen,
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
        radius: 30);
  }

  static Future<void> showErrorDialog(String message) async {
    await Get.defaultDialog(
        title: "Cultyvate",
        middleText: message,
        backgroundColor: cultLightGrey,
        titleStyle: const TextStyle(color: cultRed),
        middleTextStyle: const TextStyle(color: cultRed),
        radius: 30);
  }
}
