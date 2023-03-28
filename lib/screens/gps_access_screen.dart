import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            
            return !state.isgpsEnabled 
              ? _EnableGps()
              : _AccessButton();
          },
        ),
      ),
    );
  }
}

class _EnableGps extends StatelessWidget {
  const _EnableGps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final locationBloc = BlocProvider.of<LocationBloc>(context, listen: false).clearSubscription();

    return const Text(
      'Debe habilitar el GPS',
      style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        const Text(
          'Esnecesario el acceso al GPS',
          style: TextStyle( fontSize: 25, fontWeight: FontWeight.w300 ),
        ),

        const SizedBox( height: 10 ),

        ElevatedButton(
          onPressed: () {
            
            final gpsBloc = BlocProvider.of<GpsBloc>(context, listen: false);
            gpsBloc.askGpsAccess();

          },          
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all( const StadiumBorder() )
          ),
          child: const Text(
            'Solicitar acceso',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          
        )

      ],
    );
  }
}