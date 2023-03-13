import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_sell/order/order_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
     backgroundColor: Colors.cyan,
     title: Text("My orders"),
   ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _firestore
              .collection('user')
              .doc(_auth.currentUser!.uid)
              .collection('orders')
              .where("status", isEqualTo: "normal")
              .orderBy("placeorderTime", descending: true)
              .snapshots(),
          builder: (context, datasnapshot) {
            if (datasnapshot.hasData) {
              final datasnap = datasnapshot.data!.docs as dynamic;
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: datasnap.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                          future: FirebaseFirestore.instance.collection('orders').where('orederId',isEqualTo: datasnap[index]['orederId']).get(),
                          builder: (context,snapshot){

                            if(snapshot.hasData)
                              {
                                final snap=snapshot.data!.docs as dynamic;
                                return OrderCard(data: snap[0]['productIds'], quantity: snap[0]['productquantitys']);

                                //   Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Container(
                                //     height: 300,
                                //     color: Colors.green,
                                //     child: Center(child: Text(((snap[0]['productIds'])).toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),),
                                //   ),
                                // );

                              }else{
                              return Text("no data");
                            }

                          });
                      //   Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     height: double.infinity,
                      //     width: 200,
                      //     color: Colors.red,
                      //     child: ListView.builder(
                      //         itemCount: snap[index]['productIds'].length,
                      //         itemBuilder: (context, index2) {
                      //           // print(object)
                      //           return FutureBuilder(
                      //               future: FirebaseFirestore.instance
                      //                   .collection('items')
                      //                   .where('itemId',
                      //                       isEqualTo: snap[index]['productIds']
                      //                           [index2])
                      //                   .get(),
                      //               builder: (context, snapshot) {
                      //                 final snap = snapshot.data!.docs as dynamic;
                      //                   if (snapshot.hasData) {
                      //                   // print('quantity'+(snap[index]['productquantitys'][index2]).toString());
                      //                   print((snap).runtimeType);
                      //
                      //                   return OrderCard(data: snap);
                      //                 } else {
                      //                   return Center(
                      //                     child: Text("No data"),
                      //                   );
                      //                 }
                      //               });
                      //           // OrderCard(itemId: snap[index]['productIds'][index2], quantity: (snap[index]['productquantitys'][index2]).toString());
                      //           //   Container(
                      //           //   height: (double.parse((snap.length).toString()))*200,
                      //           //   child:
                      //           //
                      //           //
                      //           //    Row(
                      //           //     children: [
                      //           //
                      //           //        Container(
                      //           //          height: 200,
                      //           //          color: Colors.blue,
                      //           //          child: StreamBuilder(
                      //           //            stream: FirebaseFirestore.instance
                      //           //                .collection('items')
                      //           //                .where('itemId', isEqualTo: snap[index]['productIds'][index2])
                      //           //            // .where('orderBy', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      //           //                .snapshots(),
                      //           //            builder: (context, snapshot) {
                      //           //              if(snapshot.hasData)
                      //           //              {
                      //           //                final snap1=snapshot.data!.docs as dynamic;
                      //           //
                      //           //                return Column(
                      //           //                  children: [
                      //           //                    Container(
                      //           //                      height:100,
                      //           //                      width: 100,
                      //           //                      child:Image.network(snap1[0]['itemurl']) ,
                      //           //                    )
                      //           //                    ,
                      //           //                    Expanded(
                      //           //
                      //           //                      child: Text(snap1[0]['itemTitle']),
                      //           //                    ),
                      //           //                    Text((snap[index]['productquantitys'][index2]).toString()),
                      //           //                  ],
                      //           //                );
                      //           //              }else{
                      //           //                return Center(child: Text("No data"),);
                      //           //              }
                      //           //            },
                      //           //          ),
                      //           //        )
                      //           //     ],
                      //           //   ),
                      //           // );
                      //         }),
                      //   ),
                      // );
                    }),
              );
            } else {
              return const Center(
                child: Text('No order'),
              );
            }
          },
        ),
      ),
    );
  }
}
