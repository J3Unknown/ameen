class PairOfIdAndName{
  late int id;
  late String name;

  PairOfIdAndName(this.id, this.name);

  PairOfIdAndName.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}