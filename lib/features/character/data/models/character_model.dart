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

  // Convert CharacterEntity instance to Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relationship': relationship,
      'profilePicture': profilePicture,
      'additionalInfo': additionalInfo,
    };
  }
}
