import 'package:ameen/utill/shared/strings_manager.dart';

class ItemsDataModel {
  List<DeliveryItem> items = [];

  ItemsDataModel.fromJson(Map<String, dynamic> json){
    json[KeysManager.data].forEach((v) => items.add(DeliveryItem.fromJson(v)));
  }
}

class DeliveryItem{
  int? id;
  int? categoryId;
  String? title;
  String? date;
  String? orderNumber;
  String? status;
  int? userId;
  int? originAddressId;
  int? destinationAddressId;
  double? originAddressLat;
  double? originAddressLong;
  double? destinationAddressLat;
  double? destinationAddressLong;
  String? note;
  String? totalPrice;
  String? fee;
  String? paymentType;
  String? paymentMethod;
  String? paymentStatus;
  int? deliveryId;
  String? deliveryTime;
  String? actualDeliveryTime;
  String? outForDeliveryTime;
  String? shippedTime;
  String? cancellationTime;
  String? cancellationReason;
  String? cancellationDescription;
  String? rateExperience;
  String? rateDeliveryTime;
  String? rateAgent;
  String? rateDescription;
  String? createdAt;
  String? updatedAt;
  String? deliveryFee;
  User? user;


  DeliveryItem.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    date = json['delivery_date_description'];
    orderNumber = json['order_number'];
    status = json['status'];
    userId = json['user_id'];
    originAddressId = json['origin_address_id'];
    destinationAddressId = json['destination_address_id'];
    originAddressLat = json['origin_address_lat'];
    originAddressLong = json['origin_address_lng'];
    destinationAddressLat = json['destination_address_lat'];
    destinationAddressLong = json['destination_address_lng'];
    note = json['note'];
    totalPrice = json['total_price'];
    fee = json['order_fee'];
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    deliveryId = json['delivery_id'];
    deliveryTime = json['delivery_time'];
    actualDeliveryTime = json['actual_delivery_time'];
    outForDeliveryTime = json['out_for_delivery_time'];
    shippedTime = json['shipped_time'];
    cancellationTime = json['cancel_time'];
    cancellationReason = json['cancellation_reason'];
    cancellationDescription = json['cancellation_description'];
    rateExperience = json['rate_experience'];
    rateDeliveryTime = json['rate_delivery_time'];
    rateDeliveryTime = json['rate_delivery_time'];
    rateAgent = json['rate_agent'];
    rateDescription = json['rate_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryFee = json['delivery_fee'];
    user = User.fromJson(json['user']);
  }
}

class User{
  late int id;
  late String name;
  late String phone;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }
}