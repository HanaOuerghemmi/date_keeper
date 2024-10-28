import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel extends EventEntity {
  EventModel({
    required CharacterModel? user,
    required String? title,
    required String? description,
    required Color? statusColor,
    required String? type,
  }) : super(
          user: user,
          title: title,
          description: description,
          statusColor: statusColor,
          type: type,
        );

  // Factory constructor for creating an instance from JSON data
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      user: json['user'] != null ? CharacterModel.fromMap(json['user'], '') : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
      statusColor: json['statusColor'] != null ? Color(json['statusColor']) : null,
      type: json['type'] as String?,
    );
  }

  // Factory constructor for creating an instance from a Firestore DocumentSnapshot
  factory EventModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventModel(
      user: data['user'] != null ? CharacterModel.fromJson(data['user']) : null,
      title: data['title'] as String?,
      description: data['description'] as String?,
      statusColor: data['statusColor'] != null ? Color(data['statusColor']) : null,
      type: data['type'] as String?,
    );
  }

  // Method to convert EventModel instance to JSON for storing back in Firebase
  Map<String, dynamic> toJson() {
    return {
      'user':  user?.toJson(),
      'title': title,
      'description': description,
      'statusColor': statusColor?.value,
      'type': type,
    };
  }
}
