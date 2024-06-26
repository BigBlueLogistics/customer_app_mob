import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/domain/entities/user.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class SignInParams {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});
}

class SignInUseCase implements UseCases<DataState<UserEntity>, SignInParams> {
  final AuthRepositoryImpl _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call(SignInParams? params) {
    return _authRepository.signIn(
        email: params!.email, password: params.password);
  }
}
