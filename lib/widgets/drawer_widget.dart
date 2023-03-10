import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:quick_sell/screen/login_screen.dart';
class customdrawer extends StatefulWidget {

  const customdrawer({Key? key}) : super(key: key);

  @override
  State<customdrawer> createState() => _customdrawerState();
}

class _customdrawerState extends State<customdrawer> {
DocumentSnapshot? userdata;
@override
  Widget build(BuildContext context) {

    return Drawer(
      width: 250,
      backgroundColor:Colors.lightBlue ,
      child: ListView(
        children: [

         Padding(
           padding: const EdgeInsets.all(8.0),
           child:   StreamBuilder(
               stream:FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
               builder: (context,snapshot){
                 if(snapshot.connectionState==ConnectionState.waiting)
                   {
                     return const Center(child: CircularProgressIndicator(),);
                   }
                 // var snap=(snapshot as dynamic

                 return Column(
                   children: [

                     CircleAvatar(
                       radius: 40,
                       backgroundImage:NetworkImage(snapshot.data!['photourl']),
                       backgroundColor: Colors.grey,
                     ),
                     Container(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child:Text(snapshot.data!['username'])),
                   ],
                 );
               }),

         ),
          const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: (){},
          ),const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.reorder),
            title: const Text("My order"),
            onTap: (){},
          ),const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.picture_in_picture_alt_rounded),
            title: const Text("Not yet resived order"),
            onTap: (){},
          ),const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("History"),
            onTap: (){},
          ),const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Serch"),
            onTap: (){},
          ),const Divider(height:2 ,color: Colors.grey,),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text("Sign Out"),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>loginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
