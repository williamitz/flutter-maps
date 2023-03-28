import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {

  final LatLng coords;
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  const MapView({super.key, required this.coords, required this.polylines, required this.markers});

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);
    print('build MapView ::: ${polylines["route"]}');

    // final _controller =  Completer<GoogleMapController>();

    final kGooglePlex = CameraPosition(
      target: coords,
      zoom: 14,
    );


    final size = MediaQuery.of(context).size;


    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(

        onPointerMove: (event) => mapBloc.add( StopFollowEvent() ),

        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: kGooglePlex,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          markers: markers.values.toSet(),
          polylines: polylines.values.toSet(),
          
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete( controller );
            mapBloc.add( InitMapEvent(controller) );
          },
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}