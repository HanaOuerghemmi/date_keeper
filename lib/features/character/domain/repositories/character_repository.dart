import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, Unit>> createCharacter(
    CharacterEntity characterEntity,
  );
  Future<Either<Failure, CharacterEntity>> updateCharacter(
      CharacterEntity characterEntity);
  Future<Either<Failure, CharacterEntity>> deleteCharacter();
  Future<Either<Failure, List<CharacterEntity>>> getAllCharactersOfUser(
      String idUser);
  Future<Either<Failure, String>> uploadCharacterImage(File imageFile);
}
