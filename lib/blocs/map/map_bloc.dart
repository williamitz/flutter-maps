import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/themes/uber.dart';
import 'package:maps_app/ui/custom_image_marker.dart';
import 'package:maps_app/ui/widgets_to_marker.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  GoogleMapController? _mapCtrl;
  final LocationBloc locationBloc;
  LatLng? mapCenter;
  
  StreamSubscription<LocationState>? location$;

  MapBloc({ required this.locationBloc}) : super( MapState()) {

    on<InitMapEvent>( _initMap );

    on<UpdatePolylineEvent>( _onPolylineNewPoint );

    on<ShowPolylinesEvent>((event, emit) => emit( state.copyWith( showPolylines: true ) ));
    on<HiddenPolylinesEvent>((event, emit) => emit( state.copyWith( showPolylines: false ) ));

    on<StartFollowEvent>( _onStartFollowing );
    on<StopFollowEvent>((event, emit) => emit( state.copyWith( followUser: false ) ));

    on<BuildPolylineDestinationEvent>((event, emit) {
      
      emit( state.copyWith( polylines: event.polylines, markers: event.markers ) );

    });

    _onListenLocation();

  }

  void _initMap( InitMapEvent event, Emitter<MapState> emit ) {

    _mapCtrl = event.controller;
    _mapCtrl!.setMapStyle( jsonEncode( uberMapTheme ) );

    emit( state.copyWith( isMapInitialized: true ) );

  }

  void _onStartFollowing( StartFollowEvent event, Emitter<MapState> emit) {

    emit( state.copyWith( followUser: true ) );
    
    if( locationBloc.state.currentPosition == null ) return;

    moveCamera( locationBloc.state.currentPosition! );

  }

  void moveCamera( LatLng coords ) {

    _mapCtrl!.animateCamera(
      CameraUpdate.newLatLng( coords )
    );

  }

  void _onListenLocation() {

    location$ = locationBloc.stream.listen(( locationState ) {

      if( locationState.currentPosition != null ) {
        add( UpdatePolylineEvent( locationState.historyPosition ) );
      }

      if( !state.followUser || locationState.currentPosition == null ) return;

      moveCamera( locationState.currentPosition! );

    });

  }

  void _onPolylineNewPoint( UpdatePolylineEvent event, Emitter<MapState> emit){

    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.locationHistory
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['myRoute'] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );
  }

  Future<void> drawRoutePolyline( RouteDestination destination ) async {

    final myRoute = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.black,
      width: 3,
      points: destination.points,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap
    );

    double kms = destination.distance / 1000;
    kms = (kms * 100).floorToDouble();
    kms /= 100;

    double tripDuration = ( destination.duration / 60 ).floorToDouble();

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines['route'] = myRoute;

    final startMarker = Marker(
      markerId: const MarkerId('startMarker'),
      position: destination.points.first,
      infoWindow: const InfoWindow(
        title: 'Inicio',
        snippet: 'Este es mi punto inicial'
      ),
      anchor: const Offset( 0.07, 0.9),
      // icon: await getNetworkImageMarker()
      icon: await getStartCustomMarker( destination: 'Mi ubicación', minutes: tripDuration.toString() )
    );

    final endMarker = Marker(
      markerId: const MarkerId('endMarker'),
      position: destination.points.last,
      infoWindow: InfoWindow(
        title: destination.description,
        snippet: 'Distancia: $kms km, duración: $tripDuration'
      ),
      // icon: await getAssetImageMarker()
      icon: await getEndCustomMarker( destination: destination.description, distance: kms.toString() )
    );

    final currentMarkers = Map<String, Marker>.from( state.markers );
    currentMarkers['startMarker'] = startMarker;
    currentMarkers['endMarker'] = endMarker;

    add( BuildPolylineDestinationEvent( polylines: currentPolylines, markers: currentMarkers ) );

    await Future.delayed( const Duration( milliseconds: 300 ) );

    // _mapCtrl?.showMarkerInfoWindow( const MarkerId('endMarker') );

  }

  @override
  Future<void> close() {
    
    location$?.cancel();

    return super.close();
  }

}
