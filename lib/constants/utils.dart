import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

//snakbar to show messages.
void showSnackBar(
    {required BuildContext context,
    required String text,
    required Color snakBarColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: snakBarColor,
      content: Text(text, style: const TextStyle(color: Colors.white))));
}

//function to select images
Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    //intialize file picker
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    //checking if any file is selected
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
        print("Image path: ${files.files[i].path}");
      }
    }
  } catch (e) {
    //rare case when file picker fails to load
    debugPrint(e.toString());
  }
  return images;
}
