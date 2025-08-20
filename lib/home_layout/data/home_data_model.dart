import 'package:ameen/Repo/pair_of_id_and_name.dart';

class HomeDataModel{
  late PairOfIdAndName banners;

  HomeDataModel.fromJson(Map<String, dynamic> json){
    banners = PairOfIdAndName.fromJson(json['banners'][0]);
  }
}