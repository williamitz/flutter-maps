import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/models/places_response.dart';
import 'package:maps_app/services/traffic_service.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {

  TrafficService tafficsvc;

  PlaceBloc({ required this.tafficsvc }) : super( PlaceState() ) {
    
    on<PlaceEvent>((event, emit) {
      // TODO: implement event handler
    });
    
    on<ShowManualMarkerEvent>((event, emit) => emit( state.copyWith( showManualMarker: true ) ));
    on<HiddeManualMarkerEvent>((event, emit) => emit( state.copyWith( showManualMarker: false ) ));

    on<NewsPlacesEvent>((event, emit) => emit( state.copyWith( places: event.places ) ));

    on<NewPlaceHistoryEvent>((event, emit) => emit( state.copyWith( places: [], history: [event.newPlace, ...state.history] ) ));

  }

  Future<RouteDestination?> getCoordsStartToEnd( LatLng start, LatLng end ) async {

    final resp = await tafficsvc.getCoordStartToEnd(start, end);
    final infoResponse = await tafficsvc.getInfoByCoords( end );

    if( resp == null ) return null;

    final distance = resp.routes[0].distance;
    final duration = resp.routes[0].duration;
    final geometry = resp.routes[0].geometry;

    final points = decodePolyline(geometry, accuracyExponent: 6);

    final latLngList = points.map((e) => LatLng( e[0].toDouble(), e[1].toDouble() ) ).toList();

    return RouteDestination(
      points: latLngList, 
      duration: duration, 
      distance: distance,
      description: infoResponse!.placeName
    );

  }

  Future getPlacesByQuery( LatLng proximity, String query ) async {

    final newPlaces = await tafficsvc.getResultByQuery( proximity, query );
    add( NewsPlacesEvent( newPlaces ) );

  }

}
