import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ameen/google_map_services/data/map_screen_arguments.dart';
import 'package:ameen/representitive/home_layout/cubit/representative_cubit.dart';
import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class DeliveryMap extends StatefulWidget {
  const DeliveryMap({super.key, required this.arguments});
  final MapScreenArguments arguments;

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {

  GoogleMapController? _controller;
  LatLng? _currentPosition;

  bool gettingLocation = true;

  Position? _position;

  String? apiKey;

  late double originLat;
  late double originLong;


  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    apiKey = dotenv.env['API_KEY'];
    originLat = double.parse(widget.arguments.isOrigin?widget.arguments.item.originAddressLat!:widget.arguments.item.destinationAddressLat!);
    originLong = double.parse(widget.arguments.isOrigin?widget.arguments.item.originAddressLong!:widget.arguments.item.destinationAddressLong!);
    polylinePoints = PolylinePoints(apiKey: apiKey!);
    _trackSelf();
    _getCurrentLocation();
    _updateDriverLocation();
  }

  void _updateDriverLocation() {
    if(!widget.arguments.isOrigin){
      Timer.periodic(Duration(milliseconds: 3500), (timer) async{
        final pos = await Geolocator.getCurrentPosition();
        if(mounted){
          RepresentativeCubit.get(context).ping(LatLng(pos.latitude, pos.longitude), int.parse(widget.arguments.item.id!));
        }
      });
    }
  }

  Future<void> _getRoutePolyline(LatLng start, LatLng destination) async {

    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition?.latitude},${_currentPosition?.longitude}&destination=$originLat,$originLong&mode=driving&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);


    List<LatLng> cords = [];
    if (data['routes'].isNotEmpty) {
      final steps = data['routes'][0]['legs'][0]['steps'];
      for (var step in steps) {
        String polyline = step['polyline']['points'];
        cords.addAll(PolylinePoints.decodePolyline(polyline).map((p) => LatLng(p.latitude, p.longitude),));
      }

      if(mounted){
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blue,
            width: 6,
            points: cords,
            jointType: JointType.round
          ),
        );
        setState(() {});
      }
    }
  }

  Future<void> _getCurrentLocation() async{
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    setState(() {
      _position = pos;
      _currentPosition = LatLng(_position!.latitude, _position!.longitude);
      gettingLocation = false;
    });
    _getRoutePolyline(_currentPosition!, LatLng(originLat, originLong));
  }

  void _trackSelf() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      final latLng = LatLng(pos.latitude, pos.longitude);
      if(mounted){
        setState(() {
          _currentPosition = latLng;
        });
      }

      if(_controller != null && mounted){
        _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
      }
      _getRoutePolyline(_currentPosition!, LatLng(originLat, originLong));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.translate('Order Delivery'), style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: ConditionalBuilder(
        condition: !gettingLocation,
        fallback: (context) => Center(child: Text('Loading...'),),
        builder: (context) => GoogleMap(
          polylines: _polylines,
          initialCameraPosition: CameraPosition(
            target: LatLng(originLat, originLong),
            zoom: 14
          ),
          markers: {
            Marker(
              markerId: const MarkerId("destination"),
              position: LatLng(originLat, originLong),
              infoWindow: const InfoWindow(title: "Delivery Destination"),
            ),
          },
          myLocationEnabled: true,
          buildingsEnabled: true,
          onMapCreated: (c) => _controller = c,
        ),
      ),
    );
  }
}
