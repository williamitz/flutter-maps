import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;
import 'package:maps_app/markers/markers.dart';

Future<BitmapDescriptor> getStartCustomMarker( {required String minutes, required String destination} ) async {

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas( recorder );

  const size = ui.Size( 350, 150 );


  final startMarker = StartMarker(minutes: minutes, destination: destination);

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();

  final img = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await img.toByteData( format: ui.ImageByteFormat.png );


  return BitmapDescriptor.fromBytes( byteData!.buffer.asUint8List() );

}

Future<BitmapDescriptor> getEndCustomMarker( {required String distance, required String destination} ) async {

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas( recorder );

  const size = ui.Size( 350, 150 );


  final startMarker = EndMarker(distance: distance, destination: destination);

  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();

  final img = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await img.toByteData( format: ui.ImageByteFormat.png );


  return BitmapDescriptor.fromBytes( byteData!.buffer.asUint8List() );

}