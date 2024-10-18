import 'dart:io';

import 'package:date_keeper/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<void> createCharacter(CharacterModel characterModel);
  Future<CharacterModel> updateCharacter(CharacterModel characterModel);
  Future<void> deleteCharacter();
  Future<List<CharacterModel>> getAllCharactersOfUser(String idUser);
  Future<String> uploadCharacterImage(File imageFile);
}
