import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/character/domain/repositories/character_repository.dart';

class GetAllCaractersOfUserUsercase {
  final CharacterRepository characterRepository;
  GetAllCaractersOfUserUsercase({
    required this.characterRepository,
  });

  Stream<Either<Failure, List<CharacterEntity>>> call() {
    return characterRepository.getAllCharactersOfUser();
  }
}
