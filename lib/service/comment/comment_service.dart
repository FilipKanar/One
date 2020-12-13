import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/trash_point_comment.dart';
import 'package:one/model/user/user_data.dart';

//Contains methods used to manage comments
class CommentService {

  final CollectionReference commentPointsDataCollection =
  FirebaseFirestore.instance.collection('comments');

 //Adds Comment to firebase
  Future addComment(TrashPointComment pointComment, String pointName) async {
    return await commentPointsDataCollection.add({
      'pointId' : pointComment.pointId,
      'pointCommentContent' : pointComment.pointCommentContent,
      'userId' : pointComment.userId,
      'pointName' : pointName,
      'creationDateTime' : DateTime.now().millisecondsSinceEpoch,

    }).then((value) => setCommentPointId(value.id)).catchError((error) => print(error));
  }
  String pointName;
  Future setCommentPointId(String commentPointId) async {
    return await commentPointsDataCollection.doc(commentPointId).update({
      'commentPointId': commentPointId,
    });
  }

//Deletes all comments at selected point, used during trash point disposal
  Future deleteCommentsAtPoint(String pointId) async {
    return await commentPointsDataCollection.where('pointId', isEqualTo: pointId).get().then((value) {
      for(DocumentSnapshot documentSnapshot in value.docs){
        documentSnapshot.reference.delete();
      }
    });
  }

  List<TrashPointComment> _pointCommentDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TrashPointComment(
        pointCommentContent: doc.data()['pointCommentContent'],
        pointId: doc.data()['pointId'],
        userId: doc.data()['userId'],
        pointCommentId: doc.data()['commentPointId'],
        pointName: doc.data()['pointName'],
        creationDateTime: DateTime.fromMillisecondsSinceEpoch(doc.data()['creationDateTime']),
      );
    }).toList();
  }

  Stream<List<TrashPointComment>> getCommentsAtPoint(String pointId) {
    return commentPointsDataCollection.where('pointId', isEqualTo: pointId).snapshots().map(_pointCommentDataFromSnapshot);
  }

  Stream<List<TrashPointComment>> getCommentsUserRelated(UserData userData) {
    return commentPointsDataCollection.where('userId', isEqualTo: userData.userId).snapshots().map(_pointCommentDataFromSnapshot);
  }

}