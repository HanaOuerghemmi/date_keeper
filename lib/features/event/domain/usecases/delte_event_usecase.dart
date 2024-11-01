import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class DeleteEventUsecase {
    final EventRepository eventRepository;

  DeleteEventUsecase({required this.eventRepository});
Future<Either<Failure, Unit>> call(EventEntity? deletedEvent) async{
  return eventRepository.deleteEvent(deletedEvent: deletedEvent! );
}
}