import 'package:ameen/Repo/pair_of_id_and_name.dart';

class CitiesAndRegionsDataModel{
  late List<PairOfIdAndName> objects;

  CitiesAndRegionsDataModel.fromJson(Map<String, dynamic> json){
    objects = [];
    json['result'].forEach((v){
      objects.add(PairOfIdAndName.fromJson(v));
    });
  }
}