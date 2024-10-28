import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/character/domain/entities/character_entity.dart';
import 'package:date_keeper/features/event/data/datasources/remote_data_source/event_remotedatasource.dart';
import 'package:date_keeper/features/event/data/models/event_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventRemoteDatasourceImpl implements EventRemotedatasource{
   final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  EventRemoteDatasourceImpl({required this.firebaseFirestore, required this.auth, required this.firebaseStorage});
 
 
  @override
  Future<Either<Failure, EventModel>> createEvent({List<CharacterEntity>? listCharcter}) {
    // TODO: implement createEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent({EventEntity? deletedEvent}) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, EventEntity>> updateEvent({EventEntity? updatedEvent}) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
  
}