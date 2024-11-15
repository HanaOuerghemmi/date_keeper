import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/constants/app_constant.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/event/data/datasources/remote_data_source/event_remotedatasource.dart';
import 'package:date_keeper/features/event/data/models/event_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventRemoteDatasourceImpl implements EventRemotedatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  final FirebaseStorage firebaseStorage;

  EventRemoteDatasourceImpl({
    required this.firebaseFirestore,
    required this.auth,
    required this.firebaseStorage,
  });
//************************** CREATE EVENT *********************************/

  @override
  Future<Either<Failure, EventModel>> createEvent({EventModel? event}) async {
    if (event == null) {
      return Left(ServerFailure('Event cannot be null'));
    }

    try {
      final uidUser = auth.currentUser?.uid;
      if (uidUser == null) {
        return Left(OfflineFailure('User not logged in'));
      }

      // Add event to Firestore
      final docRef = await firebaseFirestore
          .collection(collectionUsersName)
          .doc(uidUser)
          .collection(collectionEventName)
          .add(event.toJson());
          
      // Create event model with the generated ID
      final eventWithId = event.copyWith(id: docRef.id);
      await docRef.set(eventWithId.toJson(), SetOptions(merge: true));

      return Right(eventWithId);
    } catch (e) {
      return Left(ServerFailure('Failed to create event: $e'));
    }
  }
//************************** GET ALL  EVENT *********************************/

  @override
Stream<Either<Failure, List<EventModel>>> getAllEvents() async* {
  try {
    final uidUser = auth.currentUser?.uid;
    if (uidUser == null) {
      yield Left(OfflineFailure('User not logged in'));
      return;
    }

    final eventStream = firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionEventName)
        .snapshots();

    await for (final querySnapshot in eventStream) {
      final events = querySnapshot.docs
          .map((doc) => EventModel.fromJson(doc.data()))
          .toList();
      yield Right(events);
    }
  } catch (e) {
    yield Left(ServerFailure('Failed to retrieve events: $e'));
  }
}

//************************** DELETE EVENT *********************************/

  @override
  Future<Either<Failure, Unit>> deleteEvent({EventEntity? deletedEvent}) async {
    try {
      final uidUser = auth.currentUser?.uid;
      if (uidUser == null) {
        return Left(OfflineFailure('User not logged in'));
      }

      final eventDocId = deletedEvent?.id; // Ensure you're checking for null
      log('Deleting event with ID: $eventDocId');

      if (eventDocId == null) {
        return Left(ServerFailure('Invalid event ID'));
      }

      await firebaseFirestore
          .collection(collectionUsersName)
          .doc(uidUser)
          .collection(collectionEventName)
          .doc(eventDocId)
          .delete();

      log('Successfully deleted event with ID: $eventDocId');
      return const Right(unit);
    } catch (e) {
      log('Error deleting event: $e');
      return Left(ServerFailure('Failed to delete event: $e'));
    }
  }
//************************** UPDATE EVENT *********************************/
  @override
  Future<Either<Failure, EventEntity>> updateEvent({EventModel? updatedEvent}) async {

     if (updatedEvent == null) {
       return Left(ServerFailure('Updated event cannot be null'));
     }

     try {
       final uidUser = auth.currentUser?.uid;
       if (uidUser == null) {
         return Left(OfflineFailure('User not logged in'));
       }

       final eventDocId = updatedEvent.id; // Ensure the updatedEvent has an ID
       if (eventDocId == null) {
         return Left(ServerFailure('Invalid event ID'));
       }

       await firebaseFirestore
           .collection(collectionUsersName)
           .doc(uidUser)
           .collection(collectionEventName)
           .doc(eventDocId)
           .set(updatedEvent.toJson(), SetOptions(merge: true));

       return Right(updatedEvent);
     } catch (e) {
       log('Error updating event: $e');
       return Left(ServerFailure('Failed to update event: $e'));
     }
  }
  //************************** GETALL EVENT BY CHARACTER EVENT *********************************/

@override
Future<Either<Failure, List<EventModel>>> getAllEventsByCharacter({String? idCharacter}) async {
  try {
    final uidUser = auth.currentUser?.uid;
    if (uidUser == null) {
      return Left(OfflineFailure('User not logged in'));
    }
    
    if (idCharacter == null || idCharacter.isEmpty) {
      return Left(ServerFailure('Character ID is required'));
    }

    final querySnapshot = await firebaseFirestore
        .collection(collectionUsersName)
        .doc(uidUser)
        .collection(collectionEventName)
        .where('user.id', isEqualTo: idCharacter)
        .get();

    final events = querySnapshot.docs
        .map((doc) => EventModel.fromJson(doc.data()))
        .toList();

    return Right(events);
  } catch (e) {
    return Left(ServerFailure('Failed to retrieve events by character: $e'));
  }
}

}
