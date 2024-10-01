import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_text_style.dart';

class SnackBarMessages {


  static void showToastErrorBottom({
    required String message,
    int? seconds,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: seconds ?? 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.sp,
      );

  static void showToastSuccessBottom({
    required String message,
    int? seconds,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: seconds ?? 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.sp,
      );
  static void showErrorMessage(BuildContext context, String errMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error),
            const SizedBox(width: 10),
            Text(errMessage, style: CustomTextStyle.normalTextStyle),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 229, 35, 21),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showConfirmingMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 70.h,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: GestureDetector(
          onTap: () async {
            await LaunchApp.openApp(
              androidPackageName: 'com.google.android.gm',
              openStore: true,
            );
          },
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Press here to check your inbox',
                    style: CustomTextStyle.normalTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
