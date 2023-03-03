import 'dart:typed_data';

class UserModel{
  final String email;
  final String username;
  final String photourl;
  final String status;
  final String uid;
   List? usercart;
  UserModel({required this.email,required this.username,required this.uid,required this.photourl,required this.status,this.usercart});
}
