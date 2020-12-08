import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';

class HorizontalImageList extends StatefulWidget {

  final List<Cleaning> cleaningsList;

  HorizontalImageList({this.cleaningsList});

  @override
  _HorizontalImageListState createState() => _HorizontalImageListState();
}

class _HorizontalImageListState extends State<HorizontalImageList> {

  @override
  Widget build(BuildContext context) {
    return widget.cleaningsList==null || widget.cleaningsList.isEmpty ? Container() : ListView.builder(
      itemCount: widget.cleaningsList.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: widget.cleaningsList[index].downloadPictureUrl.isNotEmpty ? new Image.network(widget.cleaningsList[index].downloadPictureUrl) : Image.asset('assets/logo/logo_no_text.png',height: 50,),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
