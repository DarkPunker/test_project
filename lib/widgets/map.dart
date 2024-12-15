import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(1.620163, -75.605241),
        initialZoom: 19,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
        // MarkerLayer(
        //   markers: [
        //     Marker(
        //       point: startPoint,
        //       child: Icon(Icons.location_pin, color: Colors.red, size: 40),
        //     ),
        //     Marker(
        //       point: endPoint,
        //       child: Icon(Icons.location_pin, color: Colors.blue, size: 40),
        //     ),
        //   ],
        // ),
        // PolylineLayer(
        //   polylines: [
        //     Polyline(
        //       points: routePoints,
        //       color: Colors.blue,
        //       strokeWidth: 4.0,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
