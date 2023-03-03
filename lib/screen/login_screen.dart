import 'package:flutter/material.dart';
import 'package:quick_sell/resources/authentication.dart';
import 'package:quick_sell/screen/home_screen.dart';
import 'package:quick_sell/screen/singup_screen.dart';
import 'package:quick_sell/utils/color.dart';
import 'package:quick_sell/utils/imageUtils.dart';
import 'package:quick_sell/widgets/text_input.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading=false;
  @override
  loginUser()async{
    setState(() {
      _isLoading=true;
    });
    String res=await AuthMethod().loginUser(email: _emailController.text, password:_passwordcontroller.text);
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

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordcontroller.dispose();
    _emailController.dispose();
  }
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
                Container(
                  height: MediaQuery.of(context).size.height*.40,
                  child: Image.asset("images/login.png"),
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
                    hinttext: 'Enter your password',
                    inputtype: TextInputType.text,
                    textEditingController: _passwordcontroller,
                    ispass: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:10 , horizontal: 14),
                  child: TextButton(
                    onPressed: () {
                      if(_emailController.text.isEmpty&&!(_emailController.text.contains('@')))
                        {
                          showSnakbar('Enter the correct email address', context);
                        }else if(_passwordcontroller.text.isEmpty){
                        showSnakbar('Enter the password', context);

                      }
                      else{
                        loginUser();
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
                          child:!_isLoading?const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ):const CircularProgressIndicator(color: Colors.white,)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account ?"),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const signUpScreen()));
                          },
                          child: const Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
