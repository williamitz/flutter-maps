import 'dart:convert';

import 'package:maps_app/models/models.dart';

class Leg {
    Leg({
        required this.viaWaypoints,
        required this.admins,
        required this.weight,
        required this.duration,
        required this.steps,
        required this.distance,
        required this.summary,
    });

    List<dynamic> viaWaypoints;
    List<Admin> admins;
    double weight;
    double duration;
    List<dynamic> steps;
    double distance;
    String summary;

    factory Leg.fromJson(String str) => Leg.fromMap(json.decode(str));

    factory Leg.fromMap(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromMap(x))),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
    );

}
