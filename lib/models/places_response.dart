// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponse {
    PlacesResponse({
        this.type,
        // required this.query,
        required this.features,
        this.attribution,
    });

    String? type;
    // List<String> query;
    List<Feature> features;
    String? attribution;

    factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

    factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
    );

}

class Feature {
    Feature({
        required this.id,
        required this.type,
        this.placeType,
        required this.properties,
        required this.textEs,
        required this.placeNameEs,
        required this.text,
        required this.placeName,
        required this.center,
        required this.geometry,
        this.address,
        required this.context,
    });

    String id;
    String type;
    List<String>? placeType;
    Properties properties;
    String textEs;
    String placeNameEs;
    String text;
    String placeName;
    List<double> center;
    Geometry geometry;
    String? address;
    List<Context> context;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        address: json["address"],
        context: List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
    );

    @override
  String toString() {
    return 'Feature ::: { text: $text, placeName: $placeName }';
  }
}

class Context {
    Context({
        required this.id,
        required this.textEs,
        required this.text,
        required this.mapboxId,
        this.shortCode,
        this.wikidata,
        this.languageEs,
        this.language,
    });

    String id;
    String textEs;
    String text;
    String mapboxId;
    String? shortCode;
    String? wikidata;
    String? languageEs;
    String? language;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        textEs: json["text_es"],
        text: json["text"],
        mapboxId: json["mapbox_id"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
        languageEs: json["language_es"],
        language: json["language"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "text_es": textEs,
        "text": text,
        "mapbox_id": mapboxId,
        "short_code": shortCode,
        "wikidata": wikidata,
        "language_es": languageEs,
        "language": language,
    };
}

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
        this.interpolated,
    });

    String type;
    List<double> coordinates;
    bool? interpolated;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        interpolated: json["interpolated"],
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "interpolated": interpolated,
    };
}

class Properties {
    Properties({
        this.accuracy,
        this.mapboxId,
        this.overridePostcode,
    });

    String? accuracy;
    String? mapboxId;
    String? overridePostcode;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        accuracy: json["accuracy"],
        mapboxId: json["mapbox_id"],
        overridePostcode: json["override:postcode"],
    );

    Map<String, dynamic> toMap() => {
        "accuracy": accuracy,
        "mapbox_id": mapboxId,
        "override:postcode": overridePostcode,
    };
}
