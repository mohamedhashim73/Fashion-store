import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/repositories/profile_repo/profile_repo.dart';

class ProfileLocalRepository extends ProfileRepository{
  @override

  Future<UserModel> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future deleteMyAccount() {
    // TODO: implement deleteMyAccount
    throw UnimplementedError();
  }

}