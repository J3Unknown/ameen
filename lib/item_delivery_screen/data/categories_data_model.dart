import 'package:ameen/Repo/pair_of_id_and_name.dart';
import 'package:ameen/utill/shared/strings_manager.dart';

class CategoriesDataModel{
  late List<PairOfIdAndName> category;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    category = [];
    json[KeysManager.result].forEach((v) => category.add(PairOfIdAndName.fromJson(v)));
  }

}