import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class GetAllEventUsecase {
  final EventRepository eventRepository;

  GetAllEventUsecase({required this.eventRepository});


   Stream<Either<Failure, List<EventEntity>>> call() async* {
    yield* eventRepository.getAllEvents();
  }
}
