part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class ShowManualMarkerEvent extends PlaceEvent {}
class HiddeManualMarkerEvent extends PlaceEvent {}

class NewsPlacesEvent extends PlaceEvent {

  final List<Feature> places;

  NewsPlacesEvent(this.places);

}

class NewPlaceHistoryEvent extends PlaceEvent {

  final Feature newPlace;

  NewPlaceHistoryEvent(this.newPlace);

}
