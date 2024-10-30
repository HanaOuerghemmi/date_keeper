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
        await remoteDataSource.createEvent(event: event as EventModel);
        return right(event);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }

  }

  @override
  Future<Either<Failure, Unit>> deleteEvent({EventEntity? deletedEvent}) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EventEntity>> updateEvent({EventEntity? updatedEvent}) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }

}