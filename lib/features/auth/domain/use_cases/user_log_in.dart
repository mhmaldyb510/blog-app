import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements UseCase<User, UserLogInParams> {
  final AuthRepository authRepository;

  UserLogIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLogInParams params) async {
    return await authRepository.logInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;

  UserLogInParams({required this.email, required this.password});
}
