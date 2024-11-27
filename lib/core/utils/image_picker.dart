import 'package:image_picker/image_picker.dart';

class ImagePickerUtil
{
  static Future<XFile?> pickImage(
      ImageSource source
      )  async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    return image;
  }

}

