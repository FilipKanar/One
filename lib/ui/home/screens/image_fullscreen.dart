import 'package:flutter/material.dart';

class ImageFullscreen extends StatelessWidget {
  final String url;
  ImageFullscreen(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.network(url)),
    );
  }
}
