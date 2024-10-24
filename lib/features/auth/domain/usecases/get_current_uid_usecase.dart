import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/error/failures.dart';
import 'package:date_keeper/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUidUseCase {
  final AuthRepository authRepository;

  GetCurrentUidUseCase({required this.authRepository});

  Future<Either<Failure, String>> call() async {
    return authRepository.getCurrentUID();
  }
}
