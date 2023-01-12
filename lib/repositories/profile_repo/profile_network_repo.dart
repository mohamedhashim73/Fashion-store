import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/repositories/profile_repo/profile_repo.dart';
import 'package:dio/dio.dart';
import '../../shared/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileNetworkRepository extends ProfileRepository{
  @override

  Future<UserModel> getUserData() async {
    // TODO: implement getUserData
    Response response = await Dio().get("https://api.escuelajs.co/api/v1/users/$userId");  // in the form of JSON
    return UserModel.fromJson(response.data);   // transformed json data to to userModel
  }

  @override
  Future<dynamic> deleteMyAccount({required int userID}) async {
    Response response = await Dio().delete("https://api.escuelajs.co/api/v1/users/$userId");
    return response;    // response maybe true is deleted successfully and maybe another result
  }

}