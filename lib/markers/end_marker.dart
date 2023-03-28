

import 'package:flutter/material.dart';

class EndMarker extends CustomPainter {

  // final String minutes;
  final String distance;
  final String destination;

  EndMarker({required this.distance, required this.destination});

  @override
  void paint(Canvas canvas, Size size) {
    
    final paint = Paint()
                  ..color = Colors.black
                  ..strokeWidth = 10;
    
    final whitePaint = Paint()
                  ..color = Colors.white
                  ..strokeWidth = 10;

    const double circleRadius = 20;

    const double circleRadiusWhite = 7;


    // black circle
    canvas.drawCircle( 
      Offset( size.width * 0.5 , size.height  - circleRadius), 
      circleRadius, 
      paint
    );

    // white circle
    canvas.drawCircle( 
      Offset( size.width * 0.5 , size.height  - circleRadius), 
      circleRadiusWhite, 
      whitePaint
    );

    final path = Path()
                  ..moveTo( 10,  20)
                  ..lineTo( size.width - 10, 20 )
                  ..lineTo( size.width - 10, 100 )
                  ..lineTo( 10, 100 );

    

    // boxShadow
    canvas.drawShadow(path, Colors.black, 10, false);
    
    // caja
    canvas.drawPath(path, whitePaint );

    // caja negra
    const blackBox = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    // textos

    final textSpand = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400
      ),
      text: distance
    );

    final minutesPainter = TextPainter(
      text: textSpand,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesPainter.paint(canvas, const Offset( 10, 30));

    const textSpandKm = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400
      ),
      text: 'km'
    );

    final kmPainter = TextPainter(
      text: textSpandKm,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    
    kmPainter.paint(canvas, const Offset( 10, 60));

    // info destino


    final locationSpan = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w400
      ),
      text: destination
    );

    final locationPainter = TextPainter(
      text: locationSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
      minWidth: size.width - 90,
      maxWidth: size.width - 90
    );

    final double offsetY = ( destination.length > 25 ) ? 35 : 55;
    
    locationPainter.paint(canvas, Offset( 90, offsetY));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
  
}