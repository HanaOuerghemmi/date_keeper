class UserEntity {
  final String? uid;
  final String? email;
  final String? username;
  final String? profilePictureUrl;
  final bool? isPremium;
  final String? subscriptionStatus; // 'Active', 'Inactive', 'Expired'
  final DateTime? createdAt;

  UserEntity({
    this.uid,
    this.email,
    this.username,
    this.profilePictureUrl,
    this.isPremium,
    this.subscriptionStatus,
    this.createdAt,
  });
}
