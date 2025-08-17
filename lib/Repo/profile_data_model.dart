class ProfileDataModel{
  late int id;
  late String name;
  late String email;
  late String phone;
  String? token;

  ProfileDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    token = json['token'];
  }
}