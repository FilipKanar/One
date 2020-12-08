import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:one/model/user/user_data.dart';
import 'package:one/service/user_data/user_data_service.dart';

class UserStorageService{

  String _downloadURL;

  Future uploadFile(UserData userData, File image) async {
    Reference storageReference =
    FirebaseStorage.instance.ref().child('pictures/user/profile/${userData.userId}');
    await storageReference.putFile(image);
    _downloadURL = await storageReference.getDownloadURL();
    await UserDataService(userId: userData.userId).updateUserPictureURL(_downloadURL.toString(), userData.userDataId);
  }

  String get getDownloadUrl{
    return _downloadURL;
  }

}