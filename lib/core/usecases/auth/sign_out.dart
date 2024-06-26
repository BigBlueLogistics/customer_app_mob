import 'package:customer_app_mob/core/data/repository/auth_repository.dart';
import 'package:customer_app_mob/core/domain/entities/user.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';
import 'package:customer_app_mob/core/utils/use_cases.dart';

class SignOutUseCase implements UseCases<DataState<UserEntity>, dynamic> {
  final AuthRepositoryImpl _authApi;

  const SignOutUseCase(this._authApi);

  @override
  Future<DataState<UserEntity>> call(params) {
    return _authApi.signOut();
  }
}
