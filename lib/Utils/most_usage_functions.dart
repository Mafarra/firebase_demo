import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

AwesomeDialog awesomeDialog(BuildContext context,
    {String? title, description, DialogType? dialogType}) {
  return AwesomeDialog(
    context: context,
    dialogType: dialogType ?? DialogType.error,
    animType: AnimType.bottomSlide,
    title: title ?? "",
    desc: description ?? "",
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}

snackSuccess(String? title, String? body) {
  mainSnack(
      body: body ?? "",
      backgroundColor: const Color(0xFF10C995).withAlpha(150));
}

snackError(String? title, String? body) {
  mainSnack(
      body: body ?? "",
      backgroundColor: const Color(0xFFF2AE56).withAlpha(150));
}

snackConnection() {
  mainSnack(
      body: 'connection',
      backgroundColor: const Color(0xFF000000).withAlpha(150));
}

mainSnack({String? title, String? body, Color? backgroundColor}) {
  Future.delayed(const Duration(seconds: 0)).then((value) {
    try {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: backgroundColor ?? const Color(0xFF303030),
          message:
              body != null && body.trim().isNotEmpty ? body : "error occurred",
          duration: const Duration(seconds: 2),
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: backgroundColor ?? const Color(0xFF303030),
          message: "error occurred",
          duration: const Duration(seconds: 2),
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      );
    }
  });
}
