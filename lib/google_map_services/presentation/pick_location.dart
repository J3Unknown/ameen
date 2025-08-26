import 'package:ameen/utill/local/localization/app_localization.dart';
import 'package:ameen/utill/shared/colors_manager.dart';
import 'package:ameen/utill/shared/strings_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/location_result.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {

  GoogleMapController? _mapController;
  LatLng? _myLatLng;
  Marker? _pickedMarker;
  String? _pickedAddress;
  bool _initializing = true;
  bool _resolvingAddress = false;

  @override
  void initState() {
    super.initState();
    _initMyLocation();
  }

  void _initMyLocation() async{
    try{
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Turn on Location Services to continue')),
          );
        }
        setState(() => _initializing = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
        }
        setState(() => _initializing = false);
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final my = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _myLatLng = my;
        _pickedMarker = Marker(
          markerId: const MarkerId('picked'),
          position: my,
          draggable: true,
          onDragEnd: _onPicked,
          infoWindow: const InfoWindow(title: 'Picked location'),
        );
        _initializing = false;
      });

      _reverseGeocode(my);

      if (_mapController != null) {
        _mapController!.moveCamera(CameraUpdate.newLatLngZoom(my, 16));
      }
    }catch(e){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get location: $e')),
        );
      }
      setState(() => _initializing = false);
    }
  }

  void _onPicked(LatLng latLng) {
    setState(() {
      _pickedMarker = _pickedMarker?.copyWith(positionParam: latLng) ??
        Marker(
          markerId: const MarkerId('picked'),
          position: latLng,
          draggable: true,
          onDragEnd: _onPicked,
          infoWindow: const InfoWindow(title: 'Picked location'),
        );
    });
    _reverseGeocode(latLng);
  }

  Future<void> _reverseGeocode(LatLng latLng) async {
    setState(() => _resolvingAddress = true);
    try {
      final placemarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      String? addr;
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [
          p.street,
          p.subLocality,
          p.locality,
          p.administrativeArea,
          p.country
        ].where((e) => (e ?? '').trim().isNotEmpty).toList();
        addr = parts.join(', ');
      }
      if (mounted) {
        setState(() => _pickedAddress = addr);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _pickedAddress = null);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not resolve address: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _resolvingAddress = false);
    }
  }

  void _confirm() {
    final marker = _pickedMarker;
    if (marker == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tap the map to pick a location')),
      );
      return;
    }
    final pos = marker.position;
    Navigator.of(context).pop(LocationResult(
      latitude: pos.latitude,
      longitude: pos.longitude,
      address: _pickedAddress,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final loading = _initializing || _myLatLng == null;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.translate(StringsManager.pickALocation), style: Theme.of(context).textTheme.headlineSmall,),),
      body: ConditionalBuilder(
        condition: !loading,
        builder: (context) => Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _myLatLng??LatLng(30, 42),
                zoom: 16
              ),
              onMapCreated: (c) {
                _mapController = c;
                _mapController!.moveCamera(
                  CameraUpdate.newLatLngZoom(_myLatLng??LatLng(30, 42), 16),
                );
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: _pickedMarker != null ? {_pickedMarker!} : {},
              onTap: _onPicked,
            )
          ],
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator(),)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _confirm(),
        backgroundColor: ColorsManager.PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        child: Icon(Icons.check, color: ColorsManager.WHITE,),
      ),
    );
  }


}
