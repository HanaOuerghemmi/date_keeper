import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final AuthMethod authMethod;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.authMethod,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,email,name];
}
  enum AuthMethod {
  email,
  google,
  apple,
}