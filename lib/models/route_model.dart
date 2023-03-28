import 'dart:convert';

import 'package:maps_app/models/models.dart';

class Route {
    Route({
        required this.weightName,
        required this.weight,
        required this.duration,
        required this.distance,
        required this.legs,
        required this.geometry,
    });

    String weightName;
    double weight;
    double duration;
    double distance;
    List<Leg> legs;
    String geometry;

    factory Route.fromJson(String str) => Route.fromMap(json.decode(str));

    factory Route.fromMap(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromMap(x))),
        geometry: json["geometry"],
    );

}
