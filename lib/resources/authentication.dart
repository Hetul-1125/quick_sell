import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_sell/resources/storageImage.dart';

class AuthMethod {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // FirebaseStorage _storage=FirebaseStorage.instance;
  Future<String> signupUser(
      {required String email,
      required String username,
      required String password,
      Uint8List? file}) async {
    String res = "some error occur";
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String photourl = await StorageImage().uploadImage(
           file: file!, childname: 'profilepics');
      await _firestore.collection('user').doc(cred.user!.uid).set({
        'username': username,
        'uid': cred.user!.uid,
        'email': email,
        'photourl': photourl,
        'status':'approved',
        'usercart':['empty'],

      });
      res = 'success';
    } catch (e) {
      res = e.toString();
      print( "catch exception...."+res);
    }
    print(res);
    return res;
  }

  //login user with email and password

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error is occur";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
      print("login user..."+res);
    }
    print(res);
    return res;
  }
}

// }
