import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/repositories/profile_repo/profile_repo.dart';
import 'package:fashion_store/shared/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../shared/constants/constants.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  late ProfileRepository profileRepository;
  UserModel? userModel;
  ProfileCubit({required this.profileRepository}) : super(ProfileInitialState());  // هسند له قيمه داخل صفحه البروفايل عشان لو هشتغل وفي نت هباصي repo for network ولو مفيش نت هباصي profile_local_repo

  Future<UserModel?> getUserInfo() async{
    emit(GetUserDataLoadingState());
    await profileRepository.getUserData().then((value){
      userModel = value;
      emit(GetUserDataSuccessState());
    }).catchError((error){
      debugPrint("there's an error during get user data from business logic layer $error");
      emit(GetUserDataErrorState());
    });
    return userModel;
  }

  Future<bool> logOut() async {
    emit(LogOutLoadingState());
    await profileRepository.deleteMyAccount().then((value) async {
      debugPrint("Response status from log out is .............. $value");
      await CacheHelper.deleteCacheItem().then((value)                          // Todo: clear all data on cache as The user will log out
      {
        emit(DeletedAccountSuccessfullyState());
      });}).catchError((error){
      debugPrint("there is an error during delete an account from business logic layer $error");
      emit(ErrorDuringDeleteAccountState());
    });
    return CacheHelper.getCacheData("UserID") == null ? true : false ;
  }
}