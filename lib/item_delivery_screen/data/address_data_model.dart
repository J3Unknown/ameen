import '../../Repo/pair_of_id_and_name.dart';

class Address{
  int? id;
  String? floorNo;
  String? buildingNo;
  String? blockNo;
  String? street;
  String? landmark;
  PairOfIdAndName? region;
  PairOfIdAndName? city;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    floorNo = json['floor_no'];
    buildingNo = json['building_no'];
    blockNo = json['block_no'];
    street = json['street'];
    landmark = json['landmark'];
    city = PairOfIdAndName.fromJson(json['city']??{});
    region = PairOfIdAndName.fromJson(json['region']??{});
  }
}