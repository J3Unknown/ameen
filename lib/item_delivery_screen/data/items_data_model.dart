import 'package:ameen/utill/shared/strings_manager.dart';

class ItemsDataModel {
  List<DeliveryItem> items = [];

  ItemsDataModel.fromJson(Map<String, dynamic> json){
    json[KeysManager.data].forEach((v) => items.add(DeliveryItem.fromJson(v)));
  }
}

class DeliveryItem{
  String? id;
  String? categoryId;
  String? title;
  String? date;
  String? orderNumber;
  String? status;
  String? userId;
  String? originAddressId;
  String? destinationAddressId;
  String? originAddressLat;
  String? originAddressLong;
  String? destinationAddressLat;
  String? destinationAddressLong;
  String? note;
  String? totalPrice;
  String? fee;
  String? paymentType;
  String? paymentMethod;
  String? paymentStatus;
  String? deliveryId;
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
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    title = json['title'];
    date = json['delivery_date_description'];
    orderNumber = json['order_number'].toString();
    status = json['status'];
    userId = json['user_id'].toString();
    originAddressId = json['origin_address_id'].toString();
    destinationAddressId = json['destination_address_id'].toString();
    originAddressLat = json['origin_address_lat'].toString();
    originAddressLong = json['origin_address_lng'].toString();
    destinationAddressLat = json['destination_address_lat'].toString();
    destinationAddressLong = json['destination_address_lng'].toString();
    note = json['note'];
    totalPrice = json['total_price'].toString();
    fee = json['order_fee'].toString();
    paymentType = json['payment_type'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    deliveryId = json['delivery_id'].toString();
    deliveryTime = json['delivery_time'];
    actualDeliveryTime = json['actual_delivery_time'];
    outForDeliveryTime = json['out_for_delivery_time'];
    shippedTime = json['shipped_time'];
    cancellationTime = json['cancel_time'];
    cancellationReason = json['cancellation_reason'];
    cancellationDescription = json['cancellation_description'];
    rateExperience = json['rate_experience'].toString();
    rateDeliveryTime = json['rate_delivery_time'].toString();
    rateDeliveryTime = json['rate_delivery_time'].toString();
    rateAgent = json['rate_agent'].toString();
    rateDescription = json['rate_description'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryFee = json['delivery_fee'].toString();
    if(json['user'] != null){
      user = User.fromJson(json['user']);
    }
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