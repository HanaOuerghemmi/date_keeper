import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> getAllEvents();
  Future<Either<Failure, List<EventEntity>>> getAllEventsByCharacter({String idCharacter});
  Future<Either<Failure, EventEntity>> createEvent({EventEntity? event});
  Future<Either<Failure, EventEntity>> updateEvent({EventEntity updatedEvent});
  Future<Either<Failure, Unit>> deleteEvent({EventEntity? deletedEvent});

}