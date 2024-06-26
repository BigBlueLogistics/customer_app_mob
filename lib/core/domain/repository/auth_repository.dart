import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> signIn(
      {required String email, required String password});
  Future<DataState<UserModel>> signOut();
  Future<DataState<UserModel>> resetPassword(String email);
}
