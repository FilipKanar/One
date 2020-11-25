import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/convert_data_from_firebase/user_convert_from_firebase.dart';
import 'package:one/service/convert_data_from_firebase/user_data_convert_from_firebase.dart';
import 'package:one/service/user_data/user_data_service.dart';

class GoogleAuthentication {
  final FirebaseAuth _firebaseAuth;
  GoogleAuthentication(this._firebaseAuth);

  Future signInWithGoogle() async {
    //Google
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    //Firebase
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await _firebaseAuth.signInWithCredential(credential);
    //Check if user already exists in DB
    User user = result.user;
    UserDataService _userDataService = UserDataService(userId: user.uid);
    bool existence = await _userDataService.checkUserExistenceById(user.uid);
    //if user doesn't exist -> create new user data in database
    if (!existence) {
      _userDataService.addInitializingUserDataToFirebase(
        UserData(
          userId: user.uid,
          displayName: 'Google User',
          googleAuth: googleAuth.accessToken,
        ),
      );
    }
    return UserFromFirebaseUserConvert().userFromFirebaseUser(user);
  }

}