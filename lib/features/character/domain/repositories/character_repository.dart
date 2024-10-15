import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, CharacterEntity>> createCharacter(
      CharacterEntity characterEntity);
  Future<Either<Failure, CharacterEntity>> updateCharacter(
      CharacterEntity characterEntity);
  Future<Either<Failure, CharacterEntity>> deleteCharacter();
  Future<Either<Failure, List<CharacterEntity>>> getAllCharactersOfUser(
      String idUser);
}
