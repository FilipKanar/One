import 'package:cloud_firestore/cloud_firestore.dart';

//Model of single cleaning
class Cleaning{
//Timestamp
  DateTime creationDateTime;
//Cleaning data
  String cleaningId;
  String downloadPictureUrl;
//Trash point data
  String pointId;
//Creator Id
  String userId;

  Cleaning({this.cleaningId,this.pointId,this.userId,this.downloadPictureUrl,this.creationDateTime});

}