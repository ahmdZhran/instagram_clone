import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/reel_item_widget.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection("Reels").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No reels available"));
          }
          final reels = snapshot.data!.docs;
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: reels.length,
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
