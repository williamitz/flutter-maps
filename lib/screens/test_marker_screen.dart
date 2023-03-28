import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class TestMarkerScreenScreen extends StatelessWidget {
  const TestMarkerScreenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.blue,
          child: CustomPaint(
            // painter: StartMarker(
            //   destination: 'Id in cupidatat do .',
            //   minutes: '20"'
            // ),
            painter: EndMarker(
              destination: 'Id in cupidatat do pariatur voluptate culpa mollit occaecat.',
              distance: '3.5'
            ),
          ),
        ),
      ),
    );
  }
}