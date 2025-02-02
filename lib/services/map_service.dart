import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class MapService extends ChangeNotifier {
  final LatLng startPoint = LatLng(1.620163, -75.605241); 
  final LatLng endPoint =
      LatLng(1.617311, -75.605615); 
  List<LatLng> routePoints = [];

  final int maxRetries = 15; 
  final Duration retryDelay =
      Duration(seconds: 3); 

  Future<void> _getRouteWithRetry() async {
    int attempt = 0;
    bool success = false;

    while (attempt < maxRetries && !success) {
      attempt++;
      try {
        print("Intento $attempt de $maxRetries");
        await _getRoute();
        success = true;
        print('Se logro');
      } catch (e) {
        print('Error al obtener la ruta (intento $attempt): $e');
        if (attempt < maxRetries) {
          print('Reintentando en ${retryDelay.inSeconds} segundos...');
          await Future.delayed(retryDelay); 
        } else {
          print('Se agotaron los intentos');
        }
      }
    }
  }

  Future<void> _getRoute() async {
    var client = http.Client();
    String routePath =
        '/route/v1/driving/${startPoint.longitude},${startPoint.latitude};${endPoint.longitude},${endPoint.latitude}?geometries=geojson';
    final url = Uri.http('router.project-osrm.org', routePath);
    final response = await client.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).timeout(
      const Duration(seconds: 5),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final geometry = data['routes'][0]['geometry']['coordinates'];
      routePoints =
          geometry.map<LatLng>((point) => LatLng(point[1], point[0])).toList();
      notifyListeners();
    } else {
      print('Error al obtener la ruta: ${response.statusCode}');
      throw Exception('Error en la petición: ${response.statusCode}');
    }
  }
}
