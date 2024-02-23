import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import '../../../../core/utls/text_styles.dart';

void showConfirmingMessage(context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
      padding: const EdgeInsets.all(8),
      height: 70,
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
        child: const Row(children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We've sent a verification email.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Press here to check your inbox',
                style: CustomTextStyles.normalTextStyle,
              )
            ],
          ),
        ]),
      ),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
  ));
}




//Color? color color of message
// Widget? child // GestsureDectore 
// Widget? child contentOfMessage 