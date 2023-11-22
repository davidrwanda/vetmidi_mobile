import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vetmidi/components/toast.dart';

Future pickImage(ImageSource source, Function setImage) async {
  try {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 25);
    if (image == null) return;

    final imageTemporary = File(image.path);
    List<int> imageBytes = imageTemporary.readAsBytesSync();
    setImage(base64Encode(imageBytes));
  } on PlatformException catch (e) {
    showToast('Failed to pick image ${e.toString()}');
  }
}
