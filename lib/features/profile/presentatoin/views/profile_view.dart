// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:instagram_clone/features/profile/presentatoin/widgets/profile_info_widgets/profile_info_widget.dart';
// import '../widgets/saved_view_section/book_marked.dart';
// import '../widgets/feed_view_section/feed.dart';
// import '../widgets/reals_view_sectoin/reals.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   final List<Widget> _tabs = [
//     const Tab(icon: Icon(Icons.photo)),
//     const Tab(icon: Icon(Icons.tag_rounded)),
//     const Tab(icon: Icon(Icons.bookmark_border)),
//   ];

//   final List<Widget> _tabBarView = [
//     const FeedView(),
//     const RealsView(),
//     const BookMarkView(),
//   ];
//   String? documentId;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         body: ListView(
//           children: [

//             TabBar(
//               tabs: _tabs,
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 1430,
//               child: TabBarView(children: _tabBarView),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.doucumentId});
  final String doucumentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder(
        future: users.doc(doucumentId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist"));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
                child: Text("Full Name: ${data['bio']} ${data['user_name']}"));
          }

          return const Text("loading");
        });
  }
}
