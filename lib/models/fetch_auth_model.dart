// use this when there an error during create a user
class AuthModelWhenErrorState{
  int? statusCode;
  List? message;

  AuthModelWhenErrorState.fromJson(Map<String,dynamic> json){
    statusCode = json['status'];
    message = json['message'];
  }
}