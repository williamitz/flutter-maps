import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/place/place_bloc.dart';
import 'package:maps_app/models/places_response.dart';
import 'package:maps_app/models/search_result.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {

  SearchDestinationDelegate(): super(searchFieldLabel: 'Buscar');


  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      IconButton(
        onPressed: () {
          query = '';  
        }, 
        icon: Icon( Icons.clear )
      )
    ];
    
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(
      onPressed: () => close( context, SearchResult( cancel: true ) ), 
      icon: const Icon( Icons.arrow_back_ios )
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final placeBloc = BlocProvider.of<PlaceBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.currentPosition;

    placeBloc.getPlacesByQuery( proximity!, query );

    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        
        final places = state.places;

        return ListView.separated(
          itemCount: places.length,
          itemBuilder: ( _, i ) {
            
            final place = places[i];


            return ListTile(
              leading: const Icon( Icons.place_outlined, color: Colors.blue, ),
              title: Text( place.text ),
              subtitle: Text( place.placeName ),
              onTap: () {

                final result = SearchResult( 
                  cancel: false, 
                  manual: false, 
                  position: LatLng( place.center[1], place.center[0] ),
                  name: place.text,
                  description: place.placeName,
                ) ;

                placeBloc.add( NewPlaceHistoryEvent( place ) );

                close( context, result );

              },
            );

          },
          separatorBuilder: ( _ , index ) => const Divider(),

        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    final history = BlocProvider.of<PlaceBloc>(context).state.history;

    print('history ::: $history');

    return ListView(
      children: [

        ListTile(
          onTap: () {
            final placeBloc = BlocProvider.of<PlaceBloc>(context);
            placeBloc.add( ShowManualMarkerEvent() );
            close( context, SearchResult( cancel: false, manual: true ) );
          },
          leading: const Icon( Icons.location_on_outlined, color: Colors.white, ),
          title: const Text(
            'Colocar la ubicación manualmente',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),

        const Divider(),

        ...history.map(
          (e) => PlaceTile(
              place: e,
              onTap: () {

                final result = SearchResult( 
                  cancel: false, 
                  manual: false, 
                  position: LatLng( e.center[1], e.center[0] ),
                  name: e.text,
                  description: e.placeName,
                ) ;

                close( context, result );

              },
            )
        ).toList()



      ],
    );
  }
  
}

class PlaceTile extends StatelessWidget {

  final Feature place;
  final void Function()? onTap;

  const PlaceTile({super.key, required this.place, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon( Icons.place_outlined, color: Colors.blue, ),
      title: Text( place.text ),
      subtitle: Text( place.placeName ),
      onTap: onTap,
    );
  }
}
