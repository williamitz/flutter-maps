
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/places_response.dart';
import 'package:maps_app/models/route_response.dart';
import 'package:maps_app/services/services.dart';

class TrafficService {

  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final _urlTrafficBase = 'https://api.mapbox.com/directions/v5/mapbox';
  final _urlPLaceBase = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService()
  : _dioTraffic = Dio()..interceptors.add( TrafficInterceptor() ),
    _dioPlaces = Dio()..interceptors.add( PlacesInterceptor() );

  Future<RouteResponse?> getCoordStartToEnd( LatLng start, LatLng end ) async {

    try {
      final coords = '${ start.longitude },${ start.latitude };${ end.longitude },${ end.latitude }';

      final url = '$_urlTrafficBase/driving/$coords';

      final resp = await _dioTraffic.get( url );

      if( resp.statusCode != 200 ) return null;

      return RouteResponse.fromMap( resp.data );

    } catch (e) {
      return null;
    }

  }

  Future<List<Feature>> getResultByQuery( LatLng proximity, String query ) async {

    if( query.isEmpty ) return [];

      final url = '$_urlPLaceBase/$query.json';
      final qParams = {'proximity': '${ proximity.longitude },${ proximity.latitude }'};

      final resp = await _dioPlaces.get( url, queryParameters: qParams );

      if( resp.statusCode != 200 ) return [];

      final placeResponse = PlacesResponse.fromMap( resp.data );

      return placeResponse.features;

  }

  Future<Feature?> getInfoByCoords( LatLng coords ) async {


      final url = '$_urlPLaceBase/${ coords.longitude },${ coords.latitude }.json';

      final qParams = { 'limit': '1' };

      final resp = await _dioPlaces.get( url, queryParameters: qParams );

      if( resp.statusCode != 200 ) return null;

      final response = PlacesResponse.fromMap( resp.data );

      return response.features.first;

  }

}