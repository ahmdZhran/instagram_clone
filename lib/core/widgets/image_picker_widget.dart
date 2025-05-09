import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReusableImagePicker extends StatefulWidget {
  final Function(XFile?) onImageSelected;

  const ReusableImagePicker({super.key, required this.onImageSelected});

  @override
  ReusableImagePickerState createState() => ReusableImagePickerState();
}

class ReusableImagePickerState extends State<ReusableImagePicker> {
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });

      // Call the callback to pass the selected image back
      widget.onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: _selectedImage == null
                ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey[700])
                : Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: _pickImage,
          child: const Text('Select Image from Gallery'),
        ),
      ],
    );
  }
}
