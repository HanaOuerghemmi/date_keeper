import 'package:date_keeper/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<CharacterModel> createCharacter(CharacterModel characterModel);
  Future<CharacterModel> updateCharacter(CharacterModel characterModel);
  Future<CharacterModel> deleteCharacter();
  Future<List<CharacterModel>> getAllCharactersOfUser(String idUser);
}
