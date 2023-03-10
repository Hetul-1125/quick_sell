import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';

import 'package:quick_sell/screen/home_screen.dart';
import 'package:quick_sell/screen/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ReviewcartProvider>(create: (context)=>ReviewcartProvider()),
      ],
      child: MaterialApp(
          title: 'QuickSell',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.active)
                {
                  if(snapshot.hasData){
                    return const homescreen();
                  }else if(snapshot.hasError)
                    {
                      return Center(
                        child: Text("${snapshot.hasError}"),
                      );
                    }else if(snapshot.connectionState==ConnectionState.waiting){
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }
                }
              return const loginScreen();

            },
          ),
        ),
    );
  }
}


