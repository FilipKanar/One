import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/user/user_data.dart';

class UserDataConvertFromFirebase {

  /*Converting document snapshot from firebase to UserData type. */
  UserData userDataFromFirebase(QuerySnapshot documentSnapshot) {
    return documentSnapshot.docs.map((doc) {
      return UserData(
        userId: doc.data()['userId'],
        displayName: doc.data()['displayName'],
        userDataId: doc.data()['userDataId'],
        googleAuth: doc.data()['googleAuth'],
      );
    }).first;
  }

}