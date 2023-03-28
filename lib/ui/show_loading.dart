
// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading( BuildContext context ) {

  if( Platform.isAndroid ) {

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Espere por favor'),
        content: Container(
          height: 80,
          width: 100,
          margin: const EdgeInsets.only( top: 10 ),
          child: Column(
            children: const [
              Text('Calculando ruta...'),
              SizedBox( height: 15, ),
              CircularProgressIndicator( color: Colors.black, )
            ],
          ),
        ),
      ),
    );

    return;
  }

  showCupertinoDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    ),
  );

}
