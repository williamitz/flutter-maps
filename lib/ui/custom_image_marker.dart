
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;

Future<BitmapDescriptor> getAssetImageMarker() async {

  return BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
      devicePixelRatio: 2.5
    ), 
    'assets/custom-pin.png'
  );

}

Future<BitmapDescriptor> getNetworkImageMarker() async {

  final resp = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(
      responseType: ResponseType.bytes
    )
  );

  // resize img

  final imgCodec = await ui.instantiateImageCodec( resp.data, targetHeight: 100, targetWidth: 100 );
  final frame = await imgCodec.getNextFrame();
  final data = await frame.image.toByteData( format: ui.ImageByteFormat.png );

  // return BitmapDescriptor.fromBytes( resp.data, size: const Size( 0.5, 0.5) );
  if( data == null ) {
    return await getAssetImageMarker();
  }


  return BitmapDescriptor.fromBytes( data.buffer.asUint8List() );

}

