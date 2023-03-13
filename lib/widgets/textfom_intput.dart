import 'package:flutter/material.dart';
class textformInput extends StatelessWidget {
  final String hinttext;
  final TextEditingController textEditingController;
  final TextInputType inputtype;
  const textformInput({Key? key,required this.textEditingController,required this.hinttext,required this.inputtype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputborder=OutlineInputBorder(borderSide:Divider.createBorderSide(context),borderRadius:BorderRadius.circular(10) );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 18),
      child: TextFormField(
        controller:textEditingController ,
        decoration: InputDecoration(
          hintText: hinttext,
          filled: true,
          focusedBorder: inputborder,
          enabledBorder:inputborder,
          border: inputborder,
        ),
        keyboardType: inputtype,
        validator: (value)=>value!.isEmpty?"${hinttext} can't be Empty":null,


      ),
    );
  }
}
