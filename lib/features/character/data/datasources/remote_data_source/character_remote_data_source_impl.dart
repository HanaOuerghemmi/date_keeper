// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/data/data_storage.dart';
import 'package:date_keeper/core/error/failures.dart';
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

  // Stream<QuerySnapshot<Object?>>? streamGetAllUsers() {
  //   final uidUser = auth.currentUser?.uid;
  //   return firebaseFirestore
  //       .collection(collectionUsersName)
  //       .doc(uidUser)
  //       .collection(collectionCharacterName)
  //       .snapshots();
  // }

  @override
  Future<void> createCharacter(CharacterModel characterModel) async {
    final uidUser = auth.currentUser?.uid;
    final imageFile = File(characterModel.profilePicture!);
    final imageUrl = await uploadImageToFirebase(imageFile);
    final characterModelWithPict =
        characterModel.copyWith(profilePicture: imageUrl);
    log(' user id $uidUser');
    await firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionCharacterName)
        .add(characterModelWithPict.toJson());
  }

  @override
  Future<void> deleteCharacter() {
    // TODO: implement deleteCharacter
    throw UnimplementedError();
  }

  @override
  Stream<List<CharacterModel>> getAllCharactersOfUser() async* {
try{
final uidUser = auth.currentUser?.uid;
 if (uidUser == null) {
        return;
      }
    yield* firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionCharacterName)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => CharacterModel.fromMap(doc.data(), doc.id))
            .toList());
}catch (e) {
      return;
    }




    @override
    Future<CharacterModel> updateCharacter(CharacterModel characterModel) {
      // TODO: implement updateCharacter
      throw UnimplementedError();
    }

    // Future<String> uploadImage(File imageFile) async {
    //   try {
    //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //     Reference storageRef =
    //         firebaseStorage.ref().child('character_images/$fileName');
    //     UploadTask uploadTask = storageRef.putFile(imageFile);
    //     TaskSnapshot snapshot = await uploadTask;
    //     String downloadUrl = await snapshot.ref.getDownloadURL();
    //     return downloadUrl;
    //   } catch (e) {
    //     print("Error uploading image: $e");
    //     return '';
    //   }
    // }

    @override
    Future<String> uploadCharacterImage(File imageFile) async {
      // final ref = firebaseStorage.ref().child('characters/${imageFile}');
      // final uploadTask = await ref.putFile(imageFile);
      // return await uploadTask.ref.getDownloadURL();
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

  @override
  Future<CharacterModel> updateCharacter(CharacterModel characterModel) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }

  @override
  Future<String> uploadCharacterImage(File imageFile) {
    // TODO: implement uploadCharacterImage
    throw UnimplementedError();
  }
}
