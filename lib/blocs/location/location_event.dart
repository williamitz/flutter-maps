part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}


// class FolowingEvent extends LocationEvent {
//   final bool isFollowing;

//   FolowingEvent(this.isFollowing);
// }

class NewPositionEvent extends LocationEvent {
  final LatLng newLocation;

  NewPositionEvent(this.newLocation);
}

class FollowingStopEvent extends LocationEvent {

}

class FollowingStartEvent extends LocationEvent {

}