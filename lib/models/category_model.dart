class CategoryModel{
  int? id;
  String? image;
  String? name;

  CategoryModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map toJson(){
    return {
      "name": name,
      "id": id,
      "image": image,
    };
  }
}