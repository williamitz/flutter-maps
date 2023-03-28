part of 'location_bloc.dart';

@immutable
abstract class LocationState {

  final bool followingUser;
  final LatLng? currentPosition;
  final List<LatLng> historyPosition;

  LocationState( { 
    required this.followingUser,
    this.currentPosition,
    historyPosition
  }): historyPosition = historyPosition ?? [];

}

class LocationInitial extends LocationState {

  LocationInitial({ super.followingUser = false });

}

class LocationGo extends LocationState {

  LocationGo({
    required super.followingUser,
    super.currentPosition,
    super.historyPosition,
  });


}