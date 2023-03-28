

import 'package:flutter/material.dart';

class StartMarker extends CustomPainter {

  final String minutes;
  // final String distance;
  final String destination;

  StartMarker({required this.minutes, required this.destination});

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
      Offset( circleRadius , size.height  - circleRadius), 
      circleRadius, 
      paint
    );

    // white circle
    canvas.drawCircle( 
      Offset( circleRadius , size.height  - circleRadius), 
      circleRadiusWhite, 
      whitePaint
    );

    final path = Path()
                  ..moveTo( 20,  20)
                  ..lineTo( size.width - 10, 20 )
                  ..lineTo( size.width - 10, 100 )
                  ..lineTo( 20, 100 );

    

    // boxShadow
    canvas.drawShadow(path, Colors.black, 10, false);
    
    // caja
    canvas.drawPath(path, whitePaint );

    // caja negra
    const blackBox = Rect.fromLTWH(20, 20, 80, 80);
    canvas.drawRect(blackBox, paint);

    // textos

    final textSpand = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400
      ),
      text: minutes
    );

    final minutesPainter = TextPainter(
      text: textSpand,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesPainter.paint(canvas, const Offset( 30, 30));

    const textSpandKm = TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400
      ),
      text: 'Min'
    );

    final kmPainter = TextPainter(
      text: textSpandKm,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );
    
    kmPainter.paint(canvas, const Offset( 25, 65));

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
      minWidth: size.width - 125,
      maxWidth: size.width - 125
    );

    final double offsetY = ( destination.length > 20 ) ? 30 : 47;
    
    locationPainter.paint(canvas, Offset( 110, offsetY));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
  
}