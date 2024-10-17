// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class CreateCaracterUsercase {
  final CharacterRepository characterRepository;
  CreateCaracterUsercase({
    required this.characterRepository,
  });

  Future<Either<Failure, Unit>> call(CharacterEntity characterEntity) async {
    return await characterRepository.createCharacter(characterEntity);
  }
}
