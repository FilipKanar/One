import 'package:flutter/material.dart';
import 'package:one/shared/appbar/AppBarCustom.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
      child: AppBarCustom(),
      ),),
    );
  }
}
