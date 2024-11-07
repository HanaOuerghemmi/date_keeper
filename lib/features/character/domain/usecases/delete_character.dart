
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class DeleteCharacterUseCase {
  final CharacterRepository characterRepository;
  DeleteCharacterUseCase({
    required this.characterRepository,
  });

  Future<Either<Failure, Unit>> call(String characterId) {
    return characterRepository.deleteCharacter(characterId);
  }
}
