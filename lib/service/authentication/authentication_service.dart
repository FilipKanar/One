import 'package:firebase_auth/firebase_auth.dart';
import 'package:one/model/user/user_from_firebase_user.dart';
import 'package:one/service/authentication/anonymous/anonymous_authentication.dart';
import 'package:one/service/authentication/email_password/email_password_authentication.dart';
import 'package:one/service/authentication/google/google_authentication.dart';
import 'package:one/service/convert_data_from_firebase/user_convert_from_firebase.dart';

class AuthenticationService {

  FirebaseAuth _firebaseAuth;

//Contains methods to authenticate with email and password
  EmailPasswordAuthentication _emailPasswordAuthentication;
  GoogleAuthentication _googleAuthentication;
  AnonymousAuthentication _anonymousAuthentication;

  AuthenticationService(){
    _firebaseAuth = FirebaseAuth.instance;
    _emailPasswordAuthentication= EmailPasswordAuthentication(_firebaseAuth);
    _googleAuthentication= GoogleAuthentication(_firebaseAuth);
    _anonymousAuthentication=AnonymousAuthentication(_firebaseAuth);
  }

  //Stream returning mapped user from Firebase. Used for identity check.
  Stream<UserFromFirebaseUser> get user  {
    return _firebaseAuth.authStateChanges().map(UserFromFirebaseUserConvert().userFromFirebaseUser);
  }
/*Sign In / Sign Up  methods: */
  Future signInWithEmailAndPassword(String email, String password) async {
    print('email password');
    print('$email , $password');
    return await _emailPasswordAuthentication.signInWithEmailAndPassword(email, password);
  }

  Future signUpWithEmailAndPassword(String email, String password, String displayName) async {
    return await _emailPasswordAuthentication.signUpWithEmailAndPassword(email, password, displayName);
  }

  Future signInWithGoogle() async {
    return await _googleAuthentication.signInWithGoogle();
  }

  Future signOut () async {
      return await _firebaseAuth.signOut();
  }

}