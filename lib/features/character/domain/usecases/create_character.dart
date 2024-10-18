// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class CreateCaracterUsercase {
  final CharacterRepository characterRepository;
  CreateCaracterUsercase({
    required this.characterRepository,
  });

  Future<Either<Failure, Unit>> call(
      CharacterEntity characterEntity, File imageFile) async {
    // First, upload the image and handle errors
    final imageUploadResult =
        await characterRepository.uploadCharacterImage(imageFile);

    // Handle failure from image upload
    return imageUploadResult.fold(
      (failure) => Left(failure), // Return image upload failure
      (imageUrl) async {
        // Proceed with character creation
        final newCharacter = characterEntity.copyWith(profilePicture: imageUrl);
        log(newCharacter.profilePicture.toString());
        // Save the character and handle errors
        final saveResult =
            await characterRepository.createCharacter(newCharacter);

        return saveResult.fold(
          (failure) => Left(failure), // Return save failure
          (_) => Right(unit), // Return success
        );
      },
    );
  }
}
