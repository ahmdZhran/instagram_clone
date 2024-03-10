import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
      return await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser!.uid)
          .get();
    }

    return FutureBuilder(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...........");
          }
          if (snapshot.hasError) {
            return const Text('there is something wrong');
          }
          if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            return Column(
              children: [
                Text(user!['email']),
                Text(user['user_name']),
                Text(user['bio']),
              ],
            );
          } else {
            return const Text('there is no data stored ');
          }
        });
//     return Column(
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ProfileCountWidget(count: '120', label: 'Following'),
//             ProfileAvatarWidget(),
//             ProfileCountWidget(count: '21.2k', label: 'Followers'),
//           ],
//         ),
//         verticalSpacer(10),
//         const Text(
//           'Eren_official',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         verticalSpacer(5),
//         const Text(
//           'Hero of Attack on Titan',
//         ),
//         const Text(
//           'youtube/attack_on_titan/official',
//           style: TextStyle(color: Colors.blue),
//         ),
//         verticalSpacer(10),
//         CustomButton(
//           childOfCustomButton: const Text(
//             'Edite Profile',
//             style: TextStyle(color: AppColors.kWhiteColor),
//           ),
//           height: 40,
//           width: 180,
//           onPressed: () {},
//         )
//       ],
//     );
//   }
// }
  }
}
