import 'package:cloud_firestore/cloud_firestore.dart';

//Model of trash point. Reflects location and data of littered place.
class TrashPoint{
//Timestamp
  DateTime creationDateTime;
//TrashPoint data
  String pointId;
  String description;
  //Location
  GeoPoint geoPoint;
  // Picture taken during first cleaning
  String initialPictureDownloadUrl;
//Creator Id - user id
  String creatorId;
//Cleanings at point data
  int trashPans;
  bool cleaned;

  TrashPoint({this.trashPans,this.description,this.pointId,this.geoPoint, this.cleaned,this.creatorId,this.initialPictureDownloadUrl,this.creationDateTime});

}