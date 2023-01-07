class UserModel{
  String? role;
  int? id;
  String? name;
  String? email;
  String? image;
  String? password;
  String? createdAt;
  String? updatedAt;

  UserModel({required this.name,required this.email,required this.password,required this.image,required this.role});

  UserModel.fromJson(Map<String,dynamic> json){
    role = json['role'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['avatar'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map toJson(){
    return {
      "name" : name,
      "email" : email,
      "password" : password,
      "role" : name,
      "avatar" : name,  // as there called avatar not image
    };
  }
}