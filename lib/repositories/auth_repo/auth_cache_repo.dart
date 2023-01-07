import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/repositories/auth_repo/auth_repo.dart';

class AuthCacheRepository extends AuthRepository{
  @override
  Future<UserModel> userSignUp({required String name, required String email, required String password}) {
    // TODO: implement userSignUp
    throw UnimplementedError();
  }

}