import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';

class LogOutUsercase {
  final AuthRepository authRepository;

  LogOutUsercase({required this.authRepository});

  Future<Either<Failure, Unit>> call() async {
    return await authRepository.logOut();
  }
}
