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
          'trashCollected': 0,
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
        .map(UserDataConvertFromFirebase().userDataFromSnapshotFirst);
  }

  Future setId(String userDataId) async {
    return await _userDataCollection.doc(userDataId).update({
      'userDataId': userDataId,
    });
  }

  Future updateUserPictureURL(String pictureDownloadURL, String userDataId) async {
    return await _userDataCollection.doc(userDataId).update({
      'pictureDownloadURL': pictureDownloadURL,
    });
  }

  Future increaseUserAchievementField(
      String userDataId, String achievementField) async {
    return await _userDataCollection.doc(userDataId).update({
      '$achievementField': FieldValue.increment(1),
    });
  }
  Future decreaseUserAchievementField(
      String userDataId, String achievementField) async {
    return await _userDataCollection.doc(userDataId).update({
      '$achievementField': FieldValue.increment(-1),
    });
  }

  Future updateUserDisplayName(String displayName, String userDataId) async {
    return await _userDataCollection.doc(userDataId).update({
      'displayName': displayName,
    });
  }

  Stream<List<UserData>> get users {
    return _userDataCollection
        .snapshots()
        .map(UserDataConvertFromFirebase().userDataFromSnapshotList);
  }
  
  Future<String> getUserDisplayNameById(String userId) async {
    return await _userDataCollection.where('userId', isEqualTo: userId).limit(1).get().then((value) {
      return UserDataConvertFromFirebase().userDisplayNameFromSnapshot(value);
    });
  }

  Future<String> getUserPictureDownloadUrlById(String userId) async {
    return await _userDataCollection.where('userId', isEqualTo: userId).limit(1).get().then((value) {
      return UserDataConvertFromFirebase().userPictureDownloadUrlFromSnapshot(value);
    });
  }



}
