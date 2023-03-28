import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/place/place_bloc.dart';
import 'package:maps_app/ui/show_loading.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {

        if( !state.showManualMarker ) {
          return Container();
        }

        return const _ManualMarkerBody();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {

  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final placeBloc = BlocProvider.of<PlaceBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [

          const _BackButton(),

          Center(
            child: Transform.translate(
              offset: const Offset( 0, -21 ),
              child: BounceInDown(
                from: 100,
                child: const Icon( Icons.location_on_rounded, size: 50, color: Colors.black, )
              ),
            ),
          ),

          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration( milliseconds: 300 ),
              child: MaterialButton(
                onPressed: () async {

                  final start = locationBloc.state.currentPosition;
                  final end = mapBloc.mapCenter;

                  if( start == null ||  end == null ) return;

                  showLoading(context);

                  final destination = await placeBloc.getCoordsStartToEnd(start, end);
                  if( destination == null ) return;

                  await mapBloc.drawRoutePolyline( destination );

                  placeBloc.add( HiddeManualMarkerEvent() );
                  
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);

                },
                minWidth: size.width - 120,
                color: Colors.black,
                shape: const StadiumBorder(),
                child: const Text(
                  'Confirmar destino',
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          )

        ],
      ),

    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 20,
      child: FadeInLeft(
        duration: const Duration( milliseconds: 300 ),
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: () {
              final placeBloc = BlocProvider.of<PlaceBloc>(context);
              placeBloc.add( HiddeManualMarkerEvent() );
            }, 
            icon: Container(
              margin: const EdgeInsets.only( left: 8 ),
              child: const Icon( Icons.arrow_back_ios, color: Colors.black, )
            )
          ),
        ),
      )
    );
  }
}