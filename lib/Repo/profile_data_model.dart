class ProfileDataModel{
  late final int id;
  late String name;
  String? email;
  bool? sahl;
  late String phone;
  String? token;

  ProfileDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    if(json['sahl'] == 0){
      sahl = false;
    } else {
      sahl = true;
    }
    token = json['token'];
  }
}