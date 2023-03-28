part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}


class InitMapEvent extends MapEvent {
  
  final GoogleMapController controller;

  InitMapEvent(this.controller);

}

class StartFollowEvent extends MapEvent {}

class StopFollowEvent extends MapEvent {}

class UpdatePolylineEvent extends MapEvent {
  final List<LatLng> locationHistory;

  UpdatePolylineEvent(this.locationHistory);
}

class ShowPolylinesEvent extends MapEvent {}
class HiddenPolylinesEvent extends MapEvent {}

class BuildPolylineDestinationEvent extends MapEvent {
  
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  BuildPolylineDestinationEvent({ required this.polylines, required this.markers});
}

