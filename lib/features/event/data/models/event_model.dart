import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:date_keeper/features/event/domain/entities/event_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel extends EventEntity {
  final String? id;

  EventModel({
    this.id,
    required CharacterModel? user,
    required String? title,
    required String? description,
    required String? statusColor,
    required String? type,
    required String? date,
  }) : super(
    id:id,
          user: user,
          title: title,
          description: description,
          statusColor: statusColor,
          type: type,
          date: date,
        );

  // Factory constructor for creating an instance from JSON data
  factory EventModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return EventModel(
      id: json['id'] as String?, // Read the id field from JSON
      user: json['user'] != null ? CharacterModel.fromJson(json['user']) : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
      statusColor: json['statusColor'] as String?,
      type: json['type'] as String?,
      date: json['date'] as String?,
    );
  }

  // Factory constructor for creating an instance from a Firestore DocumentSnapshot
  factory EventModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return EventModel(
      id: doc.id,
      user: data['user'] != null ? CharacterModel.fromJson(data['user']) : null,
      title: data['title'] as String?,
      description: data['description'] as String?,
      statusColor: data['statusColor'] as String?,
      type: data['type'] as String?,
      date: data['date'] as String?,
    );
  }

  // Method to convert EventModel instance to JSON for storing back in Firebase
  Map<String, dynamic> toJson() {
    return {
            'id': id, // Include the id field in the JSON map

      'user': user?.toJson(),
      'title': title,
      'description': description,
      'statusColor': statusColor,
      'type': type,
      'date': date,
    };
  }

  // CopyWith method to create a new instance with updated fields
  EventModel copyWith({
    String? id,
    CharacterModel? user,
    String? title,
    String? description,
    String? statusColor,
    String? type,
    String? date,
  }) {
    return EventModel(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      description: description ?? this.description,
      statusColor: statusColor ?? this.statusColor,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }
}
