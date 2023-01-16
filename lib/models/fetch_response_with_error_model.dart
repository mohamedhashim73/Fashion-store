// Todo: if I made a bad request , I will get the response in this form
class ResponseWithErrorModel{
  late int statusCode;
  late List message;
  late String error;

  ResponseWithErrorModel.fromJson(Map<String,dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }
}