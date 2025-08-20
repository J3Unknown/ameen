class ProfileDataModel{
  late final int id;
  late String name;
  String? email;
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