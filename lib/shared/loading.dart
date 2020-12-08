import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        color: Colors.lightGreen[100],
        child: SpinKitRotatingCircle(
          color: Colors.lightGreen,
          size: 50.0,
        ),
      ),
    );
  }
}
