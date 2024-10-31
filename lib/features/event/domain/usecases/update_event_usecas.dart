import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class UpdateEventUsecase {
    final EventRepository eventRepository;

  UpdateEventUsecase({required this.eventRepository});
Future<Either<Failure, EventEntity>> call(EventEntity updatedEvent) async{
  return eventRepository.updateEvent(updatedEvent: updatedEvent );
}
}