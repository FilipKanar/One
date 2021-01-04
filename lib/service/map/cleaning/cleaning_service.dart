import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/map/cleaning.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/file/image_service.dart';
import 'package:one/service/map/trash_point/trash_point_service.dart';
import 'package:one/service/user_data/user_data_service.dart';

class CleaningService {

  //Services
  ImageService imageService = ImageService();
  TrashPointService pointService = TrashPointService();

  //Firestore reference
  final CollectionReference cleaningsDataCollection =
  FirebaseFirestore.instance.collection('cleanings');

  Future addCleaning(Cleaning cleaning, File image, String userDataId) async {
    return await cleaningsDataCollection.add({
      'userId' : cleaning.userId,
      'pointId' : cleaning.pointId,
      'downloadPictureUrl' : '' ,
      'creationDateTime' : DateTime.now().millisecondsSinceEpoch,
    }).then((doc) async {
      setCleaningId(doc.id);
      cleaning.cleaningId = doc.id;
      String downloadUrl = await imageService.uploadFile(cleaning, image);
      updateDownloadUrl(doc.id, downloadUrl);
      pointService.addTrashPanToPoint(cleaning.pointId);
      UserDataService().increaseUserAchievementField(userDataId, 'trashCollected');
    }).catchError((error) {
      print(error);
    });
  }

  Future setCleaningId(String cleaningId) async{
    return await cleaningsDataCollection.doc(cleaningId).update({
      'cleaningId' : cleaningId,
    });
  }



  Future deleteCleaningsAtPoint(String pointId) async {
    return await cleaningsDataCollection.where('pointId', isEqualTo: pointId).get().then((value) {
      for(DocumentSnapshot documentSnapshot in value.docs){
        documentSnapshot.reference.delete();
      }
    });
  }
  Future deleteCleaning(String cleaningId) async {
    return await cleaningsDataCollection.doc(cleaningId).delete();
  }

  Future updateDownloadUrl(String cleaningId, String downloadPictureUrl) async{
    return await cleaningsDataCollection.doc(cleaningId).update({
      'downloadPictureUrl' : downloadPictureUrl,
    });
  }

  List<Cleaning> _cleaningDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cleaning(
        userId: doc.data()['userId'],
        pointId: doc.data()['pointId'],
        downloadPictureUrl: doc.data()['downloadPictureUrl'],
        cleaningId: doc.data()['cleaningId'],
        creationDateTime: DateTime.fromMillisecondsSinceEpoch(doc.data()['creationDateTime']),
      );
    }).toList();
  }

  Stream<List<Cleaning>> get cleanings {
    return cleaningsDataCollection.snapshots().map(_cleaningDataFromSnapshot);
  }

  Stream<List<Cleaning>> getCleaningsAtPoint(TrashPoint trashPoint) {
    return cleaningsDataCollection.where('pointId', isEqualTo: trashPoint.pointId).snapshots().map(_cleaningDataFromSnapshot);
  }


  Stream<List<Cleaning>> getCleaningsUserRelated(UserData userData) {
    return cleaningsDataCollection.where('userId', isEqualTo: userData.userId).snapshots().map(_cleaningDataFromSnapshot);
  }

  Cleaning _singleCleaningDataFromSnapshot2(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cleaning(
        userId: doc.data()['userId'],
        pointId: doc.data()['pointId'],
        downloadPictureUrl: doc.data()['downloadPictureUrl'],
        cleaningId: doc.data()['cleaningId'],
        creationDateTime: DateTime.fromMillisecondsSinceEpoch(doc.data()['creationDateTime']),
      );
    }).first;
  }

  Future<Cleaning> getImageLinkAtPoint(String pointId, String userId) async {
    return await cleaningsDataCollection.where('pointId', isEqualTo: pointId).where('userId', isEqualTo: userId).snapshots().map(_singleCleaningDataFromSnapshot2).first;
  }
}