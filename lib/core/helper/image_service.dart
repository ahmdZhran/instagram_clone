import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: source);
      if (file == null) return null;

      final Uint8List bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}


