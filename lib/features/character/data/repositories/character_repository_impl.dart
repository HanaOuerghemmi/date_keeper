import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  @override
  Future<Either<Failure, CharacterEntity>> createCharacter(
      CharacterEntity characterEntity) {
    // TODO: implement createCharacter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CharacterEntity>> deleteCharacter() {
    // TODO: implement deleteCharacter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharactersOfUser(
      String idUser) {
    // TODO: implement getAllCharactersOfUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CharacterEntity>> updateCharacter(
      CharacterEntity characterEntity) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }
}
