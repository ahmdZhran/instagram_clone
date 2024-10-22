import 'package:auto_size_text/auto_size_text.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_colors.dart';

class UtilsMessages {
  static void showToastErrorBottom(
    BuildContext context, {
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Press here to check your inbox',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.lightThemeColor,
                        ),
                      ),
                    ),
                  ],
                ),
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
