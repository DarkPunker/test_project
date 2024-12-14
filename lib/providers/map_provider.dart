import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier{
  final LatLng startPoint = LatLng(1.620163, -75.605241); 
  final LatLng endPoint =
      LatLng(1.617311, -75.605615); 
  List<LatLng> routePoints = [];
}