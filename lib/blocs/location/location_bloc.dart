import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  StreamSubscription? position$;

  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<NewPositionEvent>((event, emit) {
      emit( LocationGo(
        followingUser: state.followingUser,
        currentPosition: event.newLocation,
        historyPosition: [...state.historyPosition, event.newLocation]
      ) );
    });

    on<FollowingStartEvent>((event, emit) {
      emit( LocationInitial( followingUser: true ) );
    });

    on<FollowingStopEvent>((event, emit) {
      emit( LocationInitial( followingUser: false ) );
    });

  }

  Future<void> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    add( NewPositionEvent( LatLng( position.latitude, position.longitude ) ) );
  }

  void starFollowingUser() {

    add( FollowingStartEvent() );
    
    position$ = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        // timeLimit: Duration( seconds: 5 ),
        // distanceFilter: 5
      )
    ).listen((event) {
      
      print('new coords ::: $event');

      final position = event;
      add( NewPositionEvent( LatLng( position.latitude, position.longitude ) ) );

    });
  }

  void clearSubscription() {
    position$?.cancel();
    add( FollowingStopEvent() );
  }


  @override
  Future<void> close() {
    
    clearSubscription();

    return super.close();
  }
  
}
