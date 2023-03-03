
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageImage{

  FirebaseStorage _storage=FirebaseStorage.instance;
 Future<String> uploadImage({required Uint8List file,required String childname})async{
Reference ref=_storage.ref().child(childname).child(FirebaseAuth.instance.currentUser!.uid);
UploadTask uploadTask=ref.putData(file);
TaskSnapshot snap=await uploadTask;
String downloadurl=await snap.ref.getDownloadURL();
return downloadurl;
  }


}
