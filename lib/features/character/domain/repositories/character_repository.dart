import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, Unit>> createCharacter(
    CharacterModel characterEntity,
  );
  Future<Either<Failure, CharacterModel>> updateCharacter(
      CharacterModel characterEntity);
  Future<Either<Failure, Unit>> deleteCharacter(String charcterId);
  Stream<Either<Failure, List<CharacterModel>>> getAllCharactersOfUser();
  Future<Either<Failure, String>> uploadCharacterImage(File imageFile);
}
