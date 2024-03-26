import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/functions/image_picker_method.dart';

class AddImageProfileWidget extends StatefulWidget {
  const AddImageProfileWidget({super.key});

  @override
  State<AddImageProfileWidget> createState() => _AddImageProfileWidgetState();
}

class _AddImageProfileWidgetState extends State<AddImageProfileWidget> {
  Uint8List? imageProfile;
  void selectImageProfile() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      imageProfile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImageProfile();
      },
      child: Column(
        children: [
          imageProfile != null
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(imageProfile!),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.add_a_photo,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                ),
        ],
      ),
    );
  }
}
