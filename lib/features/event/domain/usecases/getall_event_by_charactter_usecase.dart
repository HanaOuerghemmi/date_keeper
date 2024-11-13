import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class GetallEventByCharacterUsecase {
  final EventRepository eventRepository;

  GetallEventByCharacterUsecase({required this.eventRepository});


   Future<Either<Failure, List<EventEntity>>> call(String idCharacter) async {
    return eventRepository.getAllEventsByCharacter(idCharacter: idCharacter);
  }
}
