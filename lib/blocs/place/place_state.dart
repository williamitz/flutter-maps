part of 'place_bloc.dart';

// @immutable
// abstract 
class PlaceState {

  final bool showManualMarker;
  final List<Feature> places;
  final List<Feature> history;

  PlaceState({
    this.showManualMarker = false,
    this.places = const [],
    this.history = const [],
  });

  PlaceState copyWith({
    bool? showManualMarker,
    List<Feature>? places,
    List<Feature>? history
  }) => PlaceState(
    showManualMarker: showManualMarker ?? this.showManualMarker,
    places: places ?? this.places,
    history: history ?? this.history,
  );

}
