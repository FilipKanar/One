import 'package:firebase_auth/firebase_auth.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/convert_data_from_firebase/user_convert_from_firebase.dart';
import 'package:one/service/user_data/user_data_service.dart';

class EmailPasswordAuthentication {

  final FirebaseAuth _firebaseAuth;
  EmailPasswordAuthentication(this._firebaseAuth);

//Sign In with Email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = authResult.user;
      return UserFromFirebaseUserConvert().userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

//Sign Up with email and password
  Future signUpWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      UserDataService _userDataService = UserDataService(userId: user.uid);
      _userDataService.addInitializingUserDataToFirebase(
        UserData(
          userId: user.uid,
          displayName: displayName,
        ),
      );
      return UserFromFirebaseUserConvert().userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}