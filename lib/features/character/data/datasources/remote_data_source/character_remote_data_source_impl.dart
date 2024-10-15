// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_keeper/core/constants/app_constant.dart';

import 'package:date_keeper/features/character/data/datasources/remote_data_source/character_remote_data_source.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  CharacterRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<CharacterModel> createCharacter(CharacterModel characterModel) async {
    await firebaseFirestore
        .collection(collectionCharacterName)
        .add(characterModel.toJson());

    // TODO: implement createCharacter
    throw UnimplementedError();
  }

  @override
  Future<CharacterModel> deleteCharacter() {
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
}
