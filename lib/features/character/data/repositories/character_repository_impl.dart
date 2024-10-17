// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/data/datasources/remote_data_source/character_remote_data_source_impl.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final NetworkInfo networkInfo;
  final CharacterRemoteDataSourceImpl remoteDataSource;

  CharacterRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, Unit>> createCharacter(
      CharacterEntity characterEntity) async {
    CharacterModel characterModel = CharacterModel(
      name: characterEntity.name,
      relationship: characterEntity.relationship,
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createCharacter(characterModel);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
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
