class CharacterEntity {
  final String? id; // Unique ID for Firestore reference
  final String? name;
  final String? relationship; // e.g., Spouse, Friend, etc.
  final String? profilePicture; // URL to profile image
  final String? additionalInfo; // Any extra information

  // Constructor
  CharacterEntity({
    this.id,
    this.name,
    this.relationship,
    this.profilePicture,
    this.additionalInfo,
  });
}

extension CharacterCopyWith on CharacterEntity {
  CharacterEntity copyWith({
    String? id,
    String? name,
    String? additionalInfo,
    String? profilePicture,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
