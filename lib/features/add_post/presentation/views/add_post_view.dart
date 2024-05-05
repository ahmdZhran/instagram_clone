import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery_screen.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PhotoManager.requestPermissionExtend().then((value) {
              (PermissionState state) {
                if (state.isAuth) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GalleryScreen(),
                    ),
                  );
                }
              };
            });
          },
          child: const Text('Open Your Gallery'),
        ),
      ),
    );
  }
}
