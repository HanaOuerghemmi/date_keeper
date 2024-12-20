import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class CreatEventUsescase {
    final EventRepository eventRepository;

  CreatEventUsescase({required this.eventRepository});
Future<Either<Failure, EventEntity>> call(EventEntity? event) async{
  return eventRepository.createEvent(event: event );
}
}