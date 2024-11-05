 import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageToFirebase(File imageFile) async {
    // Generate a unique file name based on timestamp or another unique identifier
    String fileName = 'characters/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Upload the file to Firebase Storage
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(fileName).putFile(imageFile);

    // Get the download URL after the upload is complete
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }