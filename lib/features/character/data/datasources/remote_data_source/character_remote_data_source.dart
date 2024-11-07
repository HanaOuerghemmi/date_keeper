import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<void> createCharacter(CharacterModel characterModel);
  Future<Either<Failure, CharacterModel>> updateCharacter({CharacterModel character});
  Future<Either<Failure, Unit>>  deleteCharacter(String charcterId);
  Stream<List<CharacterModel>> getAllCharactersOfUser();
  Future<String> uploadCharacterImage(File imageFile);
}
