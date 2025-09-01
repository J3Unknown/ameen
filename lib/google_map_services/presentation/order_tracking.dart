import 'dart:convert';
import 'dart:developer';

import 'package:ameen/item_delivery_screen/data/items_data_model.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../home_layout/cubit/main_cubit.dart';
import '../../utill/shared/constants_manager.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key, required this.item});
  final DeliveryItem item;

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  late WebSocketChannel channel;
  bool initializing = true;
  LatLng? _deliveryLocation;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }


  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

  Future<void> _connectWebSocket() async {
    if(initializing){
      final result = await context.read<MainCubit>().getDeliveryLocation(int.parse(widget.item.id!));
      setState(() {
      _deliveryLocation = result;
        initializing = false;
      });

    }

    channel = WebSocketChannel.connect(Uri.parse(AppConstants.webSocketBaseUrl));

    channel.stream.listen((message) async {
      final data = jsonDecode(message);

      if (data['event'] == 'pusher:connection_established') {
        final socketId = jsonDecode(data['data'])['socket_id'];

        if(mounted){
          String? authKey = await context.read<MainCubit>().getSocketAuth(socketId, int.parse(widget.item.id!));
          if(authKey != null){
            subscribeToChannel(authKey);
          }
        }
      }

      if (data['event'] == "client-location-update") {
        final location = jsonDecode(data['data']);
        setState(() {
          _deliveryLocation = LatLng(location['lat'], location['lng']);
        });
      }
    });
  }

  void subscribeToChannel(String authToken) {
    final subscribeMessage = {
      "event": "pusher:subscribe",
      "data": {
        "auth": authToken,
        "channel": "private-order.${widget.item.id}"
      }
    };
    channel.sink.add(jsonEncode(subscribeMessage));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate('Order Tracking'), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: ConditionalBuilder(
        condition: !initializing && _deliveryLocation != null,
        fallback: (context) => Center(child: Text('Loading...'),),
        builder: (context) => GoogleMap(
          initialCameraPosition: CameraPosition(target: _deliveryLocation!, zoom: 14),
          markers: {
            Marker(
              markerId: MarkerId('Delivery'),
              infoWindow: InfoWindow(title: 'Delivery'),
              position: _deliveryLocation!,
            ),
          },
        ),
      ),
    );
  }
}
