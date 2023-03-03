import 'package:flutter/material.dart';
class textInput extends StatelessWidget {
  final String hinttext;
  final TextEditingController textEditingController;
  final TextInputType inputtype;
  final bool ispass;
  const textInput({Key? key,required this.textEditingController,required this.hinttext,required this.inputtype,this.ispass=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder=OutlineInputBorder(borderSide:Divider.createBorderSide(context),borderRadius:BorderRadius.circular(10) );
    return TextField(
      controller:textEditingController ,
          obscureText: ispass,
      decoration: InputDecoration(
        hintText: hinttext,
       filled: true,
        focusedBorder: inputborder,
       enabledBorder:inputborder,
        border: inputborder,
      ),
      keyboardType: inputtype,


    );
  }
}
