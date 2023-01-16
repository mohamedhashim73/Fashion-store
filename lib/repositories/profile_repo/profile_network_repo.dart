import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/repositories/profile_repo/profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../models/fetch_response_with_error_model.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/constants/constants.dart';

class ProfileNetworkRepository extends ProfileRepository{
  @override

  Future<UserModel> getUserData() async {
    // TODO: implement getUserData
    Response response = await Dio().get("https://api.escuelajs.co/api/v1/users/$userId");  // in the form of JSON
    return UserModel.fromJson(response.data);   // transformed json data to to userModel
  }

  @override
  Future<dynamic> deleteMyAccount() async {
    Response response = await Dio().delete("https://api.escuelajs.co/api/v1/users/${CacheHelper.getCacheData('UserID')??userId}");
    userId = null;   // as I use this value to check it to go to AuthScreen or HomeScreen
    return response;    // response maybe true is deleted successfully and maybe another result
  }

  @override
  Future<dynamic> updateUserData({required UserModel model}) async {
    Response response = await Dio().put( "https://api.escuelajs.co/api/v1/users/${CacheHelper.getCacheData('UserID')??userId}", data: model.toJson());
    if( response.statusCode == 200 )
      {
        debugPrint("Update data status code is 200 ...................");
        return UserModel.fromJson(response.data);
      }
    else
      {
        debugPrint("Update data status code is ................ not 200");
        return ResponseWithErrorModel.fromJson(response.data);
      }
  }

}