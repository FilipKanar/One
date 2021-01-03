import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        child: SpinKitRotatingCircle(
          color: Colors.lightGreen[100],
          size: 50.0,
        ),
      ),
    );
  }
}
