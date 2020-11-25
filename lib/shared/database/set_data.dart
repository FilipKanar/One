import 'package:cloud_firestore/cloud_firestore.dart';

class SetData{
  final CollectionReference collectionReference;
  SetData(this.collectionReference);

  //Method to update specific data in database
  Future setStringData(String data, String field, String docId) async {
    return await collectionReference.doc(docId).update({
      field: data,
    });
  }
}