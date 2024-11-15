 import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

Future<String> uploadImageToFirebase(File? imageFile, {String? defaultImagePath}) async {
  try {
    // If the imageFile is null, upload the default image from assets
    if (imageFile == null || !imageFile.existsSync()) {
      // Load the default image from assets
      final byteData = await rootBundle.load(defaultImagePath!);

      // Create a temporary file to represent the default image
      final tempFile = File('${Directory.systemTemp.path}/default_image_temp.jpg')
        ..writeAsBytesSync(byteData.buffer.asUint8List(), flush: true);

      // Replace imageFile with the temporary file
      imageFile = tempFile;
    }

    // Generate a unique file name based on timestamp
    String fileName = 'characters/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Upload the file to Firebase Storage
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putFile(imageFile);

    // Get the download URL after the upload is complete
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  } catch (e) {
    // Log and rethrow the error
    print('Error uploading image: $e');
    throw Exception('Failed to upload image');
  }
}
