part of 'gps_bloc.dart';

@immutable
abstract class GpsState {

  final bool isgpsEnabled;
  final bool isgpsPermissionGranted;

  const GpsState({ 
    required this.isgpsEnabled, 
    required this.isgpsPermissionGranted
  });

  bool get isAllGranted => isgpsEnabled && isgpsPermissionGranted;



  @override
  String toString() {
    // TODO: implement toString
    return '{ isgpsEnabled: $isgpsEnabled, isgpsPermissionGranted: $isgpsPermissionGranted}';
  }

}

class GpsInitial extends GpsState {
  const GpsInitial({required super.isgpsEnabled, required super.isgpsPermissionGranted});
}

