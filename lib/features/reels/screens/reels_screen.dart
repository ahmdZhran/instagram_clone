import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/reels/widgets/reel_item_widget.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection("Reels").snapshots(),
        builder: (context, snapshot) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ReelItemWidget(
                  snapshot: snapshot.data!.docs[index].data(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
