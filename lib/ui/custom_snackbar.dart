import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  
  
  CustomSnackbar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    VoidCallback? onPressed
  }): super(
    key: key,
    content: Text( message ),
    action: SnackBarAction(
      onPressed: onPressed ?? () {},
      label: btnLabel,
    )
  );
  
  


}