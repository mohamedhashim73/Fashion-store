import 'package:dio/dio.dart';
import 'package:fashion_store/models/user_model.dart';
import '../../shared/constants/constants.dart';
import 'auth_repo.dart';

class AuthNetworkRepository extends AuthRepository {

  @override
  Future<UserModel> userSignUp({required String name, required String email, required String password}) async {
    // TODO: implement userSignUp
    Response response = await Dio().post(
      'https://api.escuelajs.co/api/v1/users',   // base url + method url
      data:
      {
        'name' : name,
        'email' : email,
        'role' : "admin",
        'avatar' : userImage,    // user image saved on constants file ad a default value
        'password' : password,
      },
    );
    UserModel model = UserModel.fromJson(response.data);
    return model;
  }

}