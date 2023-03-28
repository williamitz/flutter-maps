import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/ui/custom_snackbar.dart';

class CustomFloatingButtons extends StatelessWidget {
  const CustomFloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {

    final mapBloc      = BlocProvider.of<MapBloc>(context, listen: false);
    final locationBloc = BlocProvider.of<LocationBloc>(context);;

    return Container(
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          IconButton(
            onPressed: () {

              final coords = locationBloc.state.currentPosition!;

              if( coords == null ) {
                CustomSnackbar(message: 'No hay ubicación');
                return;
              }

              mapBloc.moveCamera( 
                coords
              );
            },
            iconSize: 40,
            icon: const CircleAvatar(
              child: Icon( Icons.my_location_outlined ),
            ),
          ),


          IconButton(
            onPressed: () {

              state.followUser 
                ? mapBloc.add( StopFollowEvent() )
                : mapBloc.add( StartFollowEvent() );
            },
            iconSize: 40,
            icon: CircleAvatar(
              child: Icon( 
                state.followUser
                  ? Icons.directions_run_outlined
                  : Icons.hail_outlined 
              ),
            ) ,
          ),


          IconButton(
            onPressed: () {

              mapBloc.state.showPolylines 
                ? mapBloc.add( HiddenPolylinesEvent() )
                : mapBloc.add( ShowPolylinesEvent() );
            },
            iconSize: 40,
            icon: CircleAvatar(
              child: Icon( state.showPolylines
                  ? Icons.directions
                  : Icons.pin_drop_outlined 
              ),
            ),
          ),

        ],
      );
        },
      )
      
    );
  }
}