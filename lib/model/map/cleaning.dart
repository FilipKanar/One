import 'package:cloud_firestore/cloud_firestore.dart';

class Cleaning{
  String cleaningId;
  String pointId;
  String userId;
  String downloadPictureUrl;
  Timestamp timestamp;
  DateTime creationDateTime;

  Cleaning({this.cleaningId,this.pointId,this.userId,this.downloadPictureUrl,this.timestamp,this.creationDateTime});

}