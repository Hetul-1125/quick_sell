import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
pickImage(ImageSource source)async{
  ImagePicker imagePicker=ImagePicker();
  XFile? file=await imagePicker.pickImage(source: source);
  if(XFile!=null)
    {
      return await file!.readAsBytes();
    }
}
showSnakbar(String content,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
