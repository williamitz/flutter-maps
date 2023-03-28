import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/blocs/place/place_bloc.dart';
import 'package:maps_app/screens/screens.dart';
import 'package:maps_app/services/traffic_service.dart';

void main() => runApp(

  MultiBlocProvider(
    providers: [
      BlocProvider( create: (context) => GpsBloc() ),
      BlocProvider( create: (context) => LocationBloc() ),
      BlocProvider( create: (context) => MapBloc( locationBloc: BlocProvider.of<LocationBloc>(context) ) ),
      BlocProvider( create: (context) => PlaceBloc( tafficsvc: TrafficService() ) ),
    ], 
    child: MapsApp()
  )

);

class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        ''  : ( _ ) => const HomeScreen(),
        'splash'  : ( _ ) => const SplashScreen(),
        'access'  : ( _ ) => const GpsAccessScreen(),
        'test'    : ( _ ) => const TestMarkerScreenScreen() 
      },
      theme: ThemeData.dark(),
    );
  }
}