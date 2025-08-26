import 'package:ameen/item_delivery_screen/data/items_data_model.dart';

class MapScreenArguments {
  DeliveryItem item;
  bool isOrigin;
  MapScreenArguments(this.item, {this.isOrigin = false});
}