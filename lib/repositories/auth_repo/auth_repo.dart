import '../../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> userSignUp({required String name,required String email,required String password});
}