import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/model/userModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userdata;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  userData() async {
    UserModel userModel;
    var value =
        await _firestore.collection('user').doc(_auth.currentUser!.uid).get();
    if (value.exists) {
      userModel = UserModel(
          email: value.get('emai'),
          username: value.get('username'),
          uid: value.get('uid'),
          photourl: value.get('photourl'),
          status: value.get('status'));
      _userdata=userModel;
      print("userdata");
      print(_userdata!);
      notifyListeners();
    }

  }
  UserModel get getUserData{

    return _userdata!;
  }
}

