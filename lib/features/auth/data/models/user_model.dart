
import 'package:date_keeper/features/auth/domaine/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
   required String id,
    required String email,
    String? name,
    required AuthMethod authMethod,
  }) : super(
     id:id,
          email: email,
          name: name!,
          authMethod: authMethod,
        );

  factory UserModel.fromFirebaseUser(firebaseUser, AuthMethod method) {
    return UserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.name ?? '',
      authMethod: method,
    );
  }
}