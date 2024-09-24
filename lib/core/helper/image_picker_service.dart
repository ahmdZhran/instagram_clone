import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<Uint8List?> pickImage(ImageSource source) async {
    XFile? file = await _imagePicker.pickImage(source: source);
    return await file?.readAsBytes();
  }
}
