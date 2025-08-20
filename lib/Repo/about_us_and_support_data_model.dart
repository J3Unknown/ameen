class AboutUsAndSupportDataModel {
  late int id;
  late String whatsappNumber;
  late String facebook;
  late String instagram;
  late String youtube;
  late String description;
  late String privacy;
  late String terms;

  AboutUsAndSupportDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    whatsappNumber = json['whatsapp_number'];
    facebook = json['facebook'];
    instagram = json['insta'];
    youtube = json['youtube'];
    description = json['description'];
    privacy = json['privacy'];
    terms = json['terms'];
  }
}