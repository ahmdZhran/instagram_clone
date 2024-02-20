// import 'package:flutter/material.dart';

// void showSnakBarMessage(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Container(
//       padding: const EdgeInsets.all(8),
//       height: 70,
//       decoration: const BoxDecoration(
//         color: Colors.green,
//         borderRadius: BorderRadius.all(
//           Radius.circular(50),
//         ),
//       ),
//       child: Row(children: [
//         const Icon(
//           Icons.check_circle,
//           color: Colors.white,
//           size: 40,
//         ),
//         const SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Success",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Text(
//               "Please check your email now to confirm.",
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             TextButton(
//               onPressed: () async {
//                 final url = Uri.parse('mailto:');
//                 if (await launchUrl(url)) {
//                   // handle successful launch
//                 } else {
//                   // handle launch failure
//                 }
//               },
//               child: const Text('Open Email'),
//             ),
//           ],
//         ),
//       ]),
//     ),
//     backgroundColor: Colors.transparent,
//     behavior: SnackBarBehavior.floating,
//   ));
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              "Success",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please check your email now to confirm.",
              style: TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ]),
    ),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Open Email',
      onPressed: () async {
        final url = Uri.parse('mailto:');
        if (await launchUrl(url)) {
          print('Email app launched successfully!');
        } else {
          print('Coudnt launch');
        }
      },
    ),
  ));
}
