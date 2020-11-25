import 'package:firebase_auth/firebase_auth.dart';
import 'package:one/model/user/user_from_firebase_user.dart';

//Used for authentication
class UserFromFirebaseUserConvert {
//Returns user instance from firebase user
  UserFromFirebaseUser userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null
        ? UserFromFirebaseUser(uid: firebaseUser.uid)
        : null;
  }
}