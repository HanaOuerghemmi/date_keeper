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

    // Check if profilePicture is not empty or null
    String imageUrl = '';
    if (characterModel.profilePicture != null &&
        characterModel.profilePicture!.isNotEmpty) {
      final imageFile = File(characterModel.profilePicture!);
      // Attempt to upload the image and get the URL
      imageUrl = await uploadImageToFirebase(imageFile);
    }

    // Create a new CharacterModel with the profile picture URL
    final characterModelWithPict =
        characterModel.copyWith(profilePicture: imageUrl);

    log('User ID: $uidUser');
    await firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionCharacterName)
        .add(characterModelWithPict.toJson());
  }

  @override
  Future<Either<Failure, Unit>> deleteCharacter(String charcterId) async {
    try {
      final uidUser = auth.currentUser?.uid;
      if (uidUser == null) {
        return Left(OfflineFailure('User not logged in'));
      }

      await firebaseFirestore
          .collection(collectionUsersName)
          .doc(uidUser)
          .collection(collectionCharacterName)
          .doc(charcterId)
          .delete();

      final querySnapshot = await firebaseFirestore
          .collection(collectionUsersName)
          .doc(uidUser)
          .collection(collectionEventName)
          .where('user.id', isEqualTo: charcterId)
          .get();

      final batch = firebaseFirestore.batch();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      log('Successfully deleted event with ID: $charcterId');
      return const Right(unit);
    } catch (e) {
      log('Error deleting event: $e');
      return Left(ServerFailure('Failed to delete event: $e'));
    }
  }

  @override
  Stream<List<CharacterModel>> getAllCharactersOfUser() async* {
    try {
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
    } catch (e) {
      return;
    }
  }

  @override
  Future<Either<Failure, CharacterModel>> updateCharacter(
      {CharacterModel? character}) async {
    try {
      final auth = FirebaseAuth.instance;
      final uidUser = auth.currentUser?.uid;

      if (uidUser == null) {
        return Left(OfflineFailure('User not logged in'));
      }

      final firebaseFirestore = FirebaseFirestore.instance;

      // Check if profilePicture has changed and needs to be uploaded
      String imageUrl = character!.profilePicture ?? '';
      if (character.profilePicture != null &&
          character.profilePicture!.isNotEmpty &&
          !character.profilePicture!.startsWith('http')) {
        final imageFile = File(character.profilePicture!);
        imageUrl = await uploadImageToFirebase(
            imageFile); // Function to upload and return the URL
      }
      // Create updated CharacterModel with new profile picture URL
      final updatedCharacter = character.copyWith(profilePicture: imageUrl);
      // Locate the document reference in Firestore
      final characterRef = firebaseFirestore
          .collection(collectionUsersName)
          .doc(uidUser)
          .collection(collectionCharacterName)
          .doc(character.id);

      // Update the document in Firestore
      await characterRef.update(updatedCharacter.toJson());

      // Return the updated character model as a success response
      return Right(updatedCharacter);
    } catch (e) {
      return Left(ServerFailure('Failed to update character: $e'));
    }
  }

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

  // @override
  // Future<String> uploadCharacterImage(File imageFile) {
  //   // TODO: implement uploadCharacterImage
  //   throw UnimplementedError();
  // }
}
