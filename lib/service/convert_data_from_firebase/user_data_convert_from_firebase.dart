import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/user/user_data.dart';

class UserDataConvertFromFirebase {

  /*Converting query snapshot from firebase to UserData type. */
  UserData userDataFromSnapshotFirst(QuerySnapshot documentSnapshot) {
    return documentSnapshot.docs.map((doc) {
      return UserData(
        userId: doc.data()['userId'],
        displayName: doc.data()['displayName'],
        userDataId: doc.data()['userDataId'],
        googleAuth: doc.data()['googleAuth'],
        trashCollected: doc.data()['trashCollected'],
        pointsCreated: doc.data()['pointsCreated'],
        pictureDownloadURL: doc.data()['pictureDownloadURL'],
      );
    }).first;
  }

  List<UserData> userDataFromSnapshotList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
        userId: doc.data()['userId'],
        displayName: doc.data()['displayName'],
        userDataId: doc.data()['userDataId'],
        googleAuth: doc.data()['googleAuth'],
        trashCollected: doc.data()['trashCollected'],
        pointsCreated: doc.data()['pointsCreated'],
        pictureDownloadURL: doc.data()['pictureDownloadURL'],
      );
    }).toList();
  }

  String userDisplayNameFromSnapshot(QuerySnapshot documentSnapshot) {
    return documentSnapshot.docs.map((doc) {
      return doc.data()['displayName'];
    }).first;
  }

  String userPictureDownloadUrlFromSnapshot(QuerySnapshot documentSnapshot) {
    return documentSnapshot.docs.map((doc) {
      return doc.data()['pictureDownloadURL'];
    }).first;
  }
}