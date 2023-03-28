
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
    SearchResult({
        required this.cancel,
        this.manual = false,
        this.position, this.name, this.description,
    });

    bool cancel;
    bool manual;
    final LatLng? position;
    final String? name;
    final String? description;

    factory SearchResult.fromJson(String str) => SearchResult.fromMap(json.decode(str));

    factory SearchResult.fromMap(Map<String, dynamic> json) => SearchResult(
        cancel: json["cancel"],
        manual: json["manual"],
    );

    @override
  String toString() {
    // TODO: implement toString
    return '{ cancel: $cancel, manual: $manual }';
  }

}
