
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  
}

class _HomeScreenState extends State<HomeScreen> {

  late LocationBloc locationBloc;
  

  @override
  void initState() {

    locationBloc = BlocProvider.of<LocationBloc>(context);
    
    locationBloc.starFollowingUser();

    super.initState();
  }

  @override
  void dispose() {

    locationBloc.clearSubscription();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {

          if( locationState.currentPosition == null ) {
            return const Center(
              child: Text('Espere por favor...'),
            );
          }

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {

              Map<String, Polyline> polylines = Map.from( mapState.polylines );
              Map<String, Marker> markers = Map.from( mapState.markers );

              if( !mapState.showPolylines ) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [

                    MapView(
                      coords: locationState.currentPosition!,
                      polylines: polylines,
                      markers: markers
                    ),
                    const SearchBar(),
                    const ManualMarker()
              
                  ],
                ),
              );
            },
            
          );             
              
        },
      ),

      floatingActionButton: const CustomFloatingButtons(),
    );
  }

  
}