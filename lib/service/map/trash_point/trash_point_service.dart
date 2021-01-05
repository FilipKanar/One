import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/map/trash_point.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/comment/comment_service.dart';
import 'package:one/service/map/cleaning/cleaning_service.dart';

class TrashPointService {

  String _pointId;

  final CollectionReference pointsDataCollection =
  FirebaseFirestore.instance.collection('trash_points');

  List<TrashPoint> _trashPointDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TrashPoint(
          trashPans: doc.data()['trashPans'],
          description: doc.data()['description'],
          pointId: doc.data()['pointId'],
          geoPoint: doc.data()['geoPoint'],
          cleaned: doc.data()['cleaned'],
          creatorId: doc.data()['creatorId'],
          creationDateTime: DateTime.fromMillisecondsSinceEpoch(doc.data()['creationDateTime']),
      );
    }).toList();
  }

  Stream<List<TrashPoint>> get trashPoints {
    return pointsDataCollection.snapshots().map((event) => _trashPointDataFromSnapshot(event));
  }

  Stream<List<TrashPoint>> getPointsUserRelated(UserData userData) {
    return pointsDataCollection.where('creatorId', isEqualTo: userData.userId).snapshots().map(_trashPointDataFromSnapshot);
  }

  Future addTrashPoint(TrashPoint point) async {
    return await pointsDataCollection.add({
      'trashPans' : 0,
      'description': point.description,
      'geoPoint': point.geoPoint,
      'cleaned': point.cleaned,
      'creatorId' : point.creatorId,
      'creationDateTime' : DateTime.now().millisecondsSinceEpoch,
    }).then((doc) {
      _pointId=doc.id;
      setPointId(doc.id);
    }).catchError((error) {
      print(error);
    });
  }
  Future setPointId(String pointId) async {
    return await pointsDataCollection.doc(pointId).update({
      'pointId': pointId,
    });
  }


  Future deletePoint(String pointId) async {
    await CleaningService().deleteCleaningsAtPoint(pointId);
    await CommentService().deleteCommentsAtPoint(pointId);
    return await pointsDataCollection.doc(pointId).delete();
  }

  Future setPointCleaned(String pointId) async {
    return await pointsDataCollection.doc(pointId).update({
      'trashPans': FieldValue.increment(1),
    });
  }

  Future addTrashPanToPoint(String pointId) async {
    return await pointsDataCollection.doc(pointId).update({
      'cleaned': true,
    });
  }

  String get returnPointId {
    return _pointId;
  }

}
