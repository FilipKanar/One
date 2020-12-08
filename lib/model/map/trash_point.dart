import 'package:cloud_firestore/cloud_firestore.dart';

class TrashPoint{
  String pointId;
  int trashPans;
  String description;
  GeoPoint geoPoint;
  String creatorId;
  bool cleaned;
  String initialPictureDownloadUrl;
  DateTime creationDateTime;

  TrashPoint({this.trashPans,this.description,this.pointId,this.geoPoint, this.cleaned,this.creatorId,this.initialPictureDownloadUrl,this.creationDateTime});

  GeoPoint get getGeoPoint{
    return geoPoint;
  }

  set setGeoPoint(GeoPoint geoPoint){
    this.geoPoint = geoPoint;
  }

  set setDescription(String description){
    this.description = description;
  }
}