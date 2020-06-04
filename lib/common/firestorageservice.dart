import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(
      BuildContext context, String imageUrl) async {
    return await FirebaseStorage.instance
        .ref()
        .child(imageUrl)
        .getDownloadURL();
  }
}
