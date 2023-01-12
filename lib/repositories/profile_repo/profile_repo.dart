import '../../models/user_model.dart';

abstract class ProfileRepository{
  // Todo: get user data
  Future<UserModel> getUserData();

  // Todo: update userData ( name || password )

  // Todo: delete an account using user's id
  Future<dynamic> deleteMyAccount();
}