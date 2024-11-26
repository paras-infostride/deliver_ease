import 'package:deliver_ease/presentation/common_components/common_components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerUtil
{
  Future<void> _onImageButtonPressed(
      ImageSource source
      ) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

  }



}

