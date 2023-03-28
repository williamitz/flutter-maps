import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/place/place_bloc.dart';
import 'package:maps_app/search/search_destination_delegate.dart';
import 'package:maps_app/ui/show_loading.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        return state.showManualMarker 
          ? Container()
          : const _SearchBarBody();
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({super.key});

  @override
  Widget build(BuildContext context) {


    void onSearchPlace() async {

      final placeBloc = BlocProvider.of<PlaceBloc>(context);
      final locationBloc = BlocProvider.of<LocationBloc>(context);
      final mapBloc = BlocProvider.of<MapBloc>(context);

      final resolve = await showSearch( context: context, delegate: SearchDestinationDelegate() );

      if( resolve == null ) return;

      if( resolve.manual ) {
        placeBloc.add( ShowManualMarkerEvent() );
        return;
      }

      if( !resolve.cancel && !resolve.manual ) {

        final start = locationBloc.state.currentPosition;

        if( start == null ) return;

        showLoading(context);

        final destination = await placeBloc.getCoordsStartToEnd(start, resolve.position!);
        if( destination == null ) return;

        await mapBloc.drawRoutePolyline( destination );

        Navigator.pop(context);

      }

      // revisar si tenemos posición

    }
    

    return FadeInDown(
      duration: const Duration( milliseconds: 300 ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric( horizontal: 30 ),
          margin: const EdgeInsets.only( top: 10 ),
          // color: Colors.blue,
          child: GestureDetector(
            onTap: onSearchPlace,
            child: Container(
              padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 16 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0,5)
                  )
                ]
              ),
              child: const Text(
                '¿Dónde quieres ir?',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}