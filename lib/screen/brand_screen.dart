import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_sell/screen/brad_item_screen.dart';

import '../utils/color.dart';
class brandScreen extends StatefulWidget {
  final String sellerId;
  final String sellername;
  const brandScreen({Key? key,required this.sellerId,required this.sellername}) : super(key: key);

  @override
  State<brandScreen> createState() => _brandScreenState();
}

class _brandScreenState extends State<brandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black54,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: linear,
          ),
        ),
      title: Text("QuickSell"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(

                  elevation: 20,
                  shadowColor: Colors.black,
                  color: Colors.blue[400],
                  child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Center(
                          child: Text(
                            "${widget.sellername}-Brand",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )))),
            ),
          ),

          Expanded(
            // flex: 2,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('sellers')
                    .doc(widget.sellerId)
                    .collection('brand')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final snap = snapshot.data!.docs as dynamic;
                    return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            child: Card(
                              // color: Colors.black54,
                              shadowColor: Colors.black,
                              elevation: 20,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>brandItem(snap: snap[index], sellerId: widget.sellerId)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: MediaQuery.of(context).size.height * .3,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image.network(
                                            snap[index]['brandurl'],
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(height: 1,),
                                  Container(
                                    child: Text(snap[index]['brandTitle'],style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),
                                  ),
                                  const SizedBox(height: 20,)

                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("No Brand Exists"),
                    );
                  }
                }),
          )
        ],
      ),


    );
  }
}
