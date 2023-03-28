
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class RouteDestination {

  final List<LatLng> points;
  final double duration;
  final double distance;
  final String description;

  RouteDestination({
    required this.points, 
    required this.duration, 
    required this.distance,
    required this.description
  });
  
}