import 'package:firebase_auth/firebase_auth.dart';
import 'package:one/service/convert_data_from_firebase/user_convert_from_firebase.dart';

class AnonymousAuthentication {
  final FirebaseAuth _firebaseAuth;
  AnonymousAuthentication(this._firebaseAuth);

  Future signInAnonymously() async {
    try {
      UserCredential authResult = await _firebaseAuth.signInAnonymously();
      User firebaseUser = authResult.user;
      return UserFromFirebaseUserConvert().userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e);
      return null;
    }
  }

}