import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/event/data/models/event_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';

abstract class  EventRemotedatasource   {
    Future<Either<Failure, List<EventModel>>> getAllEvents();
  Future<Either<Failure, EventModel>> createEvent({List<CharacterEntity>? listCharcter});
  Future<Either<Failure, EventEntity>> updateEvent({EventEntity updatedEvent});
  Future<Either<Failure, Unit>> deleteEvent({EventEntity deletedEvent});
}