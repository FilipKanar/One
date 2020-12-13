import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one/model/map/cleaning.dart';

//Contains method used to manage images
class ImageService{

  Future getCameraImage () async {
    return File((await ImagePicker().getImage(source: ImageSource.camera)).path);
  }

  Future getGalleryImage () async {
    return File((await ImagePicker().getImage(source: ImageSource.gallery)).path);
  }


//Uploads file to fire store
  Future<String> uploadFile(Cleaning cleaning, File image) async {
    Reference storageReference =
    FirebaseStorage.instance.ref().child('pictures/cleanings/${cleaning.cleaningId}.png');
    await storageReference.putFile(image);
    String _downloadURL = await storageReference.getDownloadURL();
    return _downloadURL;
  }

}