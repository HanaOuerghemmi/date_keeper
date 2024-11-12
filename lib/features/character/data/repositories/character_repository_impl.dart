// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:date_keeper/core/core.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/data/datasources/local_data_source/character_remote_data_source_impl.dart';
import 'package:date_keeper/features/character/data/datasources/remote_data_source/character_remote_data_source_impl.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final NetworkInfo networkInfo;
  final CharacterRemoteDataSourceImpl remoteDataSource;
  final CharacterLocalDataSourceImpl localDataSource;

  CharacterRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, Unit>> createCharacter(
      CharacterModel characterEntity) async {
    // CharacterModel characterModel = CharacterModel(
    //   id: characterEntity.id,
    //   name: characterEntity.name,
    //   relationship: characterEntity.relationship,
    //   profilePicture: characterEntity.profilePicture,
    //   additionalInfo: characterEntity.additionalInfo,
    // );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createCharacter(characterEntity);
        return right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCharacter(String charcterId) async {
    if (await networkInfo.isConnected) {
      try {
        // Call the remote data source to delete the character
        await remoteDataSource.deleteCharacter(charcterId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Stream<Either<Failure, List<CharacterModel>>>
      getAllCharactersOfUser() async* {
    if (await networkInfo.isConnected) {
      try {
        // Assuming getAllCharactersOfUser returns a Stream<List<CharacterModel>>
        await for (final listCharacters
            in remoteDataSource.getAllCharactersOfUser()) {
          // c for (final listCharacters
          //     in remoteDataSource.getAllCharactersOfUser()) {
          // Flatten the list of CharacterModel to a list of CharacterEntity
          //  final listCharactersEntities =
          //     listCharacters.map((character) => character.toEntity()).toList();

          // Yield the list of CharacterEntity wrapped in Right
          localDataSource.cacheCharacters(listCharacters);
          yield Right(listCharacters);
        }
      } on ServerException {
        yield Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedCharacters();
        yield Right(localPosts);
      } on EmptyCacheException {
        yield const Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, CharacterModel>> updateCharacter(
      CharacterModel characterEntity) async {
    if (await networkInfo.isConnected) {
      try {
        // Convert CharacterEntity to CharacterModel
        // final CharacterModel characterModel = CharacterModel(
        //     id: characterEntity.id,
        //     name: characterEntity.name,
        //     profilePicture: characterEntity.profilePicture,
        //     relationship: characterEntity.relationship,
        //     additionalInfo: characterEntity.additionalInfo);
        // Call the remote data source to update the character
        await remoteDataSource.updateCharacter(character: characterEntity);
        // Return the updated character entity
        return Right(characterEntity);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
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
