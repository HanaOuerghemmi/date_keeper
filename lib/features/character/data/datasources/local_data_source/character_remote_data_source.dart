


import 'package:dartz/dartz.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getCachedCharacters();
  Future<Unit> cacheCharacters(List<CharacterModel> charactersModels);
}