import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/execption.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/core/network/network_info.dart';
import 'package:date_keeper/features/event/data/datasources/remote_data_source/event_remote_datasource_impl.dart';
import 'package:date_keeper/features/event/data/models/event_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:date_keeper/features/event/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository{
    final NetworkInfo networkInfo;
final EventRemoteDatasourceImpl remoteDataSource;

  EventRepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, EventEntity>> createEvent({ EventEntity? event }) async{

    if (await networkInfo.isConnected) {
      try {
        final EventModel eventModel = EventModel(
          id: event!.id,
          user: event.user, 
          title: event.title, 
         description : event.description, 
          statusColor: event.statusColor, 
          type: event.type, date: event.date);
        await remoteDataSource.createEvent(event: eventModel);
        return right(event);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }

  }
  ///********************* get all events  ******************/
  
@override
Future<Either<Failure, List<EventEntity>>> getAllEvents() async {
  if (await networkInfo.isConnected) {
    try {
      final eventsResult = await remoteDataSource.getAllEvents();
      return eventsResult.fold(
        (failure) => Left(failure), 
        (eventsModelList) {
          // Map each EventModel to an EventEntity
          final eventsEntityList = eventsModelList.map((eventModel) {
            return EventEntity(
              id:eventModel.id ,
              user: eventModel.user,
              title: eventModel.title,
              description: eventModel.description,
              statusColor: eventModel.statusColor,
              type: eventModel.type,
              date: eventModel.date,
            );
          }).toList();
          return Right(eventsEntityList);
        },
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  } else {
    return Left(OfflineFailure());
  }
}

//*************************  delete event ********* */

  @override
   
Future<Either<Failure, Unit>> deleteEvent({EventEntity? deletedEvent}) async {
  if (await networkInfo.isConnected) {
    try {
      // Convert EventEntity to EventModel for deletion
      final EventModel eventModel = EventModel(
        id: deletedEvent!.id,
        user: deletedEvent!.user,
        title: deletedEvent.title,
        description: deletedEvent.description,
        statusColor: deletedEvent.statusColor,
        type: deletedEvent.type,
        date: deletedEvent.date,
      );
      // Call the remote data source to delete the event
      await remoteDataSource.deleteEvent(deletedEvent: eventModel);

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  } else {
    return Left(OfflineFailure());
  }
}

  @override
  Future<Either<Failure, EventEntity>> updateEvent({EventEntity? updatedEvent}) async{
    
    if (await networkInfo.isConnected) {
      try {
        final EventModel eventModel = EventModel(
          id: updatedEvent!.id,
          user: updatedEvent.user, 
          title: updatedEvent.title, 
         description : updatedEvent.description, 
          statusColor: updatedEvent.statusColor, 
          type: updatedEvent.type, date: updatedEvent.date);
        await remoteDataSource.updateEvent(updatedEvent: eventModel);
        return right(updatedEvent);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }

  }
  //************************* get all event by character ********************/
  @override
  Future<Either<Failure, List<EventEntity>>> getAllEventsByCharacter({String? idCharacter}) async{
if (await networkInfo.isConnected) {
    try {
      final eventsResult = await remoteDataSource.getAllEventsByCharacter(idCharacter: idCharacter);
      return eventsResult.fold(
        (failure) => Left(failure), 
        (eventsModelList) {
          // Map each EventModel to an EventEntity
          final eventsEntityList = eventsModelList.map((eventModel) {
            return EventEntity(
              id:eventModel.id ,
              user: eventModel.user,
              title: eventModel.title,
              description: eventModel.description,
              statusColor: eventModel.statusColor,
              type: eventModel.type,
              date: eventModel.date,
            );
          }).toList();
          return Right(eventsEntityList);
        },
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  } else {
    return Left(OfflineFailure());
  }
  }

}