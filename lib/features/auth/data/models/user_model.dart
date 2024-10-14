import 'package:date_keeper/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class UserModel extends UserEntity {
  final String? uid;
  final String? email;
  final String? username;
  final String? profilePictureUrl;
  final bool? isPremium;
  final String? subscriptionStatus; // 'Active', 'Inactive', 'Expired'
  final DateTime? createdAt;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.profilePictureUrl,
    this.isPremium,
    this.subscriptionStatus,
    this.createdAt,
  }) : super(
          uid: uid,
          email: email,
          username: username,
          profilePictureUrl: profilePictureUrl,
          isPremium: isPremium,
          subscriptionStatus: subscriptionStatus,
          createdAt: createdAt,
        );

  factory UserModel.fromFirebase(firebase.User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      username: user.displayName,
      profilePictureUrl: user.photoURL,
      // Note: Firebase User doesn't provide isPremium, subscriptionStatus, and createdAt
      // You might need to fetch these from Firestore or another data source
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      username: json['username'],
      profilePictureUrl: json['profilePictureUrl'],
      isPremium: json['isPremium'],
      subscriptionStatus: json['subscriptionStatus'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'isPremium': isPremium,
      'subscriptionStatus': subscriptionStatus,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? profilePictureUrl,
    bool? isPremium,
    String? subscriptionStatus,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      isPremium: isPremium ?? this.isPremium,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
