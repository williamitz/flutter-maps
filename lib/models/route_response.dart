// To parse this JSON data, do
//
//     final routeResponse = routeResponseFromMap(jsonString);

import 'dart:convert';

import 'package:maps_app/models/models.dart';

class RouteResponse {
    RouteResponse({
        required this.routes,
        required this.waypoints,
        required this.code,
        required this.uuid,
    });

    List<Route> routes;
    List<Waypoint> waypoints;
    String code;
    String uuid;

    factory RouteResponse.fromJson(String str) => RouteResponse.fromMap(json.decode(str));

    factory RouteResponse.fromMap(Map<String, dynamic> json) => RouteResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromMap(x))),
        waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromMap(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

}




