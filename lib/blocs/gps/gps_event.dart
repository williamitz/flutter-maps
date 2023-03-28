part of 'gps_bloc.dart';

@immutable
abstract class GpsEvent {}

class GpsPermissionEvent extends GpsEvent {
  
  final bool isgpsEnabled;
  final bool isgpsPermissionGranted;

  GpsPermissionEvent(this.isgpsEnabled, this.isgpsPermissionGranted);

}