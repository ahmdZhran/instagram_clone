import 'package:flutter/material.dart';

void showConfirmingMessage(context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: ContentOfSnakBar(),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
  ));
}

class ContentOfSnakBar extends StatelessWidget {
  const ContentOfSnakBar({
    super.key,
    this.color,
    this.onTap,
    this.contentOfSnakbarMessage,
  });
  final Color? color;
  final Function()? onTap;
  final Widget? contentOfSnakbarMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 70,
      decoration: BoxDecoration(
        color: color, // green
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        //
        // () async {
        //   await LaunchApp.openApp(
        //     androidPackageName: 'com.google.android.gm',
        //     openStore: true,
        //   );
        // },
        child: contentOfSnakbarMessage,
        //  const Row(children: [
        //   Icon(
        //     Icons.check_circle,
        //     color: Colors.white,
        //     size: 40,
        //   ),
        //   SizedBox(width: 20),
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "We've sent a verification email.",
        //         style: TextStyle(
        //           fontSize: 15,
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       Text(
        //         'Press here to check your inbox',
        //         style: CustomTextStyles.normalTextStyle,
        //       )
        //     ],
        //   ),
        // ]),
      ),
    );
  }
}
