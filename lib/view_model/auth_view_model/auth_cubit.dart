import 'package:fashion_store/models/user_model.dart';
import 'package:fashion_store/shared/cache_helper.dart';
import 'package:fashion_store/shared/constants/constants.dart';
import 'package:fashion_store/view_model/auth_view_model/auth_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthStates>{
  late AuthRepository authRepository;
  AuthCubit({required this.authRepository}) : super(InitialAppState());  // if i pass auth_network_repo or auth_cache_repo the result will be one

  // this method for sign up
  Future<UserModel?> createUser({required String name,required String email,required String password}) async {
    UserModel? model;
    emit(AuthLoadingState());
    await authRepository.userSignUp(name: name, email: email, password: password).then((value) async {
      model = value;
      debugPrint("User Data is ............. $value");
      CacheHelper.saveCacheData(key: 'userId',value: value.id).then((val)
      {
        if( val == true ) debugPrint("User id is ....... true");
        userId = CacheHelper.getCacheData('userId');
        userId?? value.id;
      });
      emit(AuthSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(AuthErrorState());
    });
    return model;
  }

}