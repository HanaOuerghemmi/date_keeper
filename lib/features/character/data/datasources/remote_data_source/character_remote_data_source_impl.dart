// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:date_keeper/core/constants/app_constant.dart';
import 'package:date_keeper/features/character/data/datasources/remote_data_source/character_remote_data_source.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  CharacterRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.auth,
    required this.firebaseStorage,
  });

  @override
  Future<void> createCharacter(CharacterModel characterModel) async {
    final uidUser = auth.currentUser?.uid;
    await firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionCharacterName)
        .add(characterModel.toJson());
  }

  @override
  Future<void> deleteCharacter() {
    // TODO: implement deleteCharacter
    throw UnimplementedError();
  }

  @override
  Future<List<CharacterModel>> getAllCharactersOfUser(String idUser) {
    // TODO: implement getAllCharactersOfUser
    throw UnimplementedError();
  }

  @override
  Future<CharacterModel> updateCharacter(CharacterModel characterModel) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          firebaseStorage.ref().child('character_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }
}
