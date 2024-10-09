import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _nestedScrollController;
  @override
  void initState() {
    _nestedScrollController = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(length: 2,child: NestedScrollView(
        controller: _nestedScrollController,
        headerSliverBuilder: ,
        body: ,
        ),
        )
    );
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    super.dispose();
  }
}
