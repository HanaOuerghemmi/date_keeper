// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

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
      id: characterEntity.id,
      name: characterEntity.name,
      relationship: characterEntity.relationship,
      profilePicture: characterEntity.profilePicture,
      additionalInfo: characterEntity.additionalInfo,
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
  Stream<Either<Failure, List<CharacterEntity>>>
      getAllCharactersOfUser() async* {
    if (await networkInfo.isConnected) {
      try {
        // Assuming getAllCharactersOfUser returns a Stream<List<CharacterModel>>
        await for (final listCharacters
            in remoteDataSource.getAllCharactersOfUser()) {
          // Flatten the list of CharacterModel to a list of CharacterEntity
          final listCharactersEntities =
              listCharacters.map((character) => character.toEntity()).toList();

          // Yield the list of CharacterEntity wrapped in Right
          yield Right(listCharactersEntities);
        }
      } on ServerException {
        yield Left(ServerFailure());
      }
    } else {
      yield Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, CharacterEntity>> updateCharacter(
      CharacterEntity characterEntity) {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadCharacterImage(File imageFile) async {
    if (await networkInfo.isConnected) {
      try {
        String urlImage =
            await remoteDataSource.uploadCharacterImage(imageFile);
        return right(urlImage);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
