import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart' show immutable;
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSbs;

  GpsBloc() : super( GpsInitial(isgpsEnabled: false, isgpsPermissionGranted: false) ) {

    on<GpsEvent>((event, emit) { });

    on<GpsPermissionEvent>((event, emit) {
      
      emit( GpsInitial(
        isgpsEnabled: event.isgpsEnabled, 
        isgpsPermissionGranted: event.isgpsPermissionGranted
      ) );

    });

    _onInit();

  }

  Future<void> _onInit() async {

    // final isEnabled = await _onCheckGpsPermision();
    // final isGranted = await _onCheckPermisionGranted();

    final permisions = await Future.wait(
      [
        _onCheckGpsPermision(),
        _onCheckPermisionGranted(),
      ]
    );

    add( GpsPermissionEvent( permisions[0], permisions[1]) );

  }

  Future<bool> _onCheckGpsPermision() async {

    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsServiceSbs = Geolocator.getServiceStatusStream().listen((event) {

      final isEnabledTwo = ( event.index == 1 ) ? true : false;

      add( GpsPermissionEvent(isEnabledTwo, state.isgpsPermissionGranted) );
    });

    return isEnabled;
  }

  Future<bool> _onCheckPermisionGranted() async {

    return await Permission.location.isGranted;

  }

  Future<void> askGpsAccess() async {

    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        
        add( GpsPermissionEvent(state.isgpsEnabled, true) );
        
        break;
      
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add( GpsPermissionEvent(state.isgpsEnabled, false) );
        openAppSettings();

    }

  }

  @override
  Future<void> close() {
    gpsServiceSbs?.cancel();

    return super.close();
  }

}
