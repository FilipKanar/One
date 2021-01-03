import 'package:flutter/material.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/shared/loading.dart';
import 'package:one/ui/home/screens/image_fullscreen.dart';

class HorizontalImageList extends StatefulWidget {
  final List<Cleaning> cleaningsList;

  HorizontalImageList({this.cleaningsList});

  @override
  _HorizontalImageListState createState() => _HorizontalImageListState();
}

class _HorizontalImageListState extends State<HorizontalImageList> {
  @override
  Widget build(BuildContext context) {
    return widget.cleaningsList == null || widget.cleaningsList.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: widget.cleaningsList.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: widget.cleaningsList[index].downloadPictureUrl.isNotEmpty
                    ? InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          ImageFullscreen(widget.cleaningsList[index].downloadPictureUrl),
                    ),);
                  },
                      child: new Image.network(
                          widget.cleaningsList[index].downloadPictureUrl),
                    )
                    : Loading(),
              );
            },
            scrollDirection: Axis.horizontal,
          );
  }
}
