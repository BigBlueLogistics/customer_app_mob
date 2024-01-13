import 'package:customer_app_mob/core/data/models/user.dart';
import 'package:customer_app_mob/core/utils/data_state.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> signIn(String email, String password);
}
