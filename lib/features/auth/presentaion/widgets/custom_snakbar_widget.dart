import 'package:flutter/material.dart';

void showSnakBarMessage(BuildContext context) {
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
        onTap: () {
          print('tapped on Row=========================');
        },
        child: Row(children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We've sent a verification email.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  children: [
                    TextSpan(
                      text: "Press ",
                    ),
                    TextSpan(
                      text: "here",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                      text: " to check your inbox.",
                    ),
                  ],
                ),
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
