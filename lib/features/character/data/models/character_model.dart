import 'package:date_keeper/features/character/domain/entities/character_entity.dart';

class CharacterModel {
  final String? id; // Unique ID for Firestore reference
  final String? name;
  final String? relationship; // e.g., Spouse, Friend, etc.
  final String? profilePicture; // URL to profile image
  final String? additionalInfo; // Any extra information

  // Constructor
  CharacterModel({
    this.id,
    this.name,
    this.relationship,
    this.profilePicture,
    this.additionalInfo,
  });

  // Factory to convert Firestore data into a Character instance
  factory CharacterModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CharacterModel(
      id: documentId,
      name: data['name'] ?? '',
      relationship: data['relationship'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
      additionalInfo: data['additionalInfo'] ?? '',
    );
  }
factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      relationship: json['relationship'] as String?,
      profilePicture: json['profilePicture'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
    );
  }
  // Convert CharacterEntity instance to Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'profilePicture': profilePicture,
      'additionalInfo': additionalInfo,
    };
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      relationship: relationship,
      profilePicture: profilePicture,
      additionalInfo: additionalInfo,
    );
  }
}
