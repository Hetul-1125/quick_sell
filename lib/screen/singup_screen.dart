import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_sell/resources/authentication.dart';
import 'package:quick_sell/screen/home_screen.dart';
import 'package:quick_sell/screen/login_screen.dart';
import 'package:quick_sell/utils/color.dart';
import 'package:quick_sell/utils/imageUtils.dart';
import 'package:quick_sell/widgets/text_input.dart';


class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmcontroller=TextEditingController();
  final TextEditingController _namecontroller=TextEditingController();
   Uint8List? _image;
   bool _isLoading=false;
   selectImage()async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
   }
   signUpUser()async{
     setState(() {
       _isLoading=true;
     });
      String res=await AuthMethod().signupUser(email: _emailController.text, username: _namecontroller.text, password:_passwordcontroller.text,file:_image );
      setState(() {
        _isLoading=false;
      });
      if(res=='success')
        {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const homescreen()));

        }
      else{
        showSnakbar(res, context);
      }


   }


  // final TextEditingController
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: linear,
            ),
          ),
          title: const Text("QuickSell"),
        ),
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                      backgroundImage: MemoryImage(_image!),
                      // backgroundColor: Colors.red,
                      radius: 64,
                    )
                        : const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                      // backgroundColor: Colors.red,
                      radius: 64,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo_sharp,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: textInput(
                    hinttext: 'Enter your email address',
                    inputtype: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: textInput(
                    hinttext: 'Enter your name',
                    inputtype: TextInputType.text,
                    textEditingController: _namecontroller,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: textInput(
                    hinttext: 'Enter your  password',
                    inputtype: TextInputType.text,
                    textEditingController: _passwordcontroller,
                    ispass: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: textInput(
                    hinttext: 'Enter your confirm password',
                    inputtype: TextInputType.text,
                    textEditingController: _confirmcontroller,
                    ispass: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10 , horizontal: 14),
                  child: TextButton(
                    onPressed: () {
                      if(_emailController.text.isEmpty||!(_emailController.text.contains('@')))
                      {
                        showSnakbar('Enter the correct email', context);
                      }else if(_namecontroller.text.isEmpty)
                      {
                        showSnakbar('Enter the name ', context);
                      }else if(_passwordcontroller.text.isEmpty&&_passwordcontroller.text.length<8)
                      {

                        showSnakbar('Enter the at least 8 letter password', context);
                      }
                      else if(_confirmcontroller.text.isEmpty)
                      {
                        showSnakbar('Enter the confirm password', context);
                      }
                      else if(_passwordcontroller.text!=_confirmcontroller.text)
                      {
                        showSnakbar('Enter the correct confirm password', context);
                      }else{
                        signUpUser();
                      }
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow,
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.red])),
                      child:  Center(
                          child: !_isLoading?const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ):const CircularProgressIndicator(color: Colors.white,)),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
