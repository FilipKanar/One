import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/convert_data_from_firebase/user_data_convert_from_firebase.dart';
import 'package:one/shared/database/set_data.dart';

class UserDataService {
  final String userId;

  UserDataService({this.userId});

  final CollectionReference _userDataCollection =
      FirebaseFirestore.instance.collection('user_data');

  //Adds UserData to database with default values and those provided during authentication
  addInitializingUserDataToFirebase(UserData userData,{String googleAuth}) async {
    return await _userDataCollection
        .add({
          'userId': userData.userId,
          'displayName': googleAuth != null ? 'Google User' : userData.displayName,
          'collectingTrash': 0,
          'pointsCreated': 0,
          'pictureDownloadURL': 'defaultPicture',
          'googleAuth' : googleAuth == null ? 'GoogleAuth not used.' : googleAuth,
        })
        .then(
          (value) => SetData(_userDataCollection)
              .setStringData(value.id, 'userDataId', value.id),
        )
        .catchError(
          (error) => print('addInitializingUserDataToFirebase error: $error'),
        );
  }

  //Checks by user Id if UserData exists in database
  Future<bool> checkUserExistenceById(String userId) async {
    bool check= true;
    var res =
    await _userDataCollection.where('userId', isEqualTo: userId).get().then((value) {
      if (value.docs.isEmpty) {
        check = false;
      } else {
        check = true;
      }
    });
    return check;
  }

  Stream<UserData> get userData {
    return _userDataCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(UserDataConvertFromFirebase().userDataFromFirebase);
  }

}
