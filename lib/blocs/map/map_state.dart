part of 'map_bloc.dart';

// @immutable
class MapState {

  final bool isMapInitialized;
  final bool followUser;

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  final bool showPolylines;

  MapState({
    this.isMapInitialized = false, 
    this.followUser = false,
    this.showPolylines = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers
  }): polylines = polylines ?? const {},
      markers = markers ?? const {} ;
  
  MapState copyWith({
    bool? isMapInitialized,
    bool? followUser,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? showPolylines,
  }) => MapState(
    followUser: followUser ?? this.followUser,
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
    showPolylines: showPolylines ?? this.showPolylines
  );
}
