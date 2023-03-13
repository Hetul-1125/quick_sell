import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  // final String itemId;
  // final String quantity;
  // final String itemcount;
  List<dynamic> data;
  List<dynamic> quantity;
  OrderCard({Key? key, required this.data, required this.quantity})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25,vertical:25),
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Container(
              height: double.parse((widget.data.length).toString())*130,
              child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('items')
                            .where('itemId',
                            isEqualTo: widget.data[index])
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final snap1 = snapshot.data!.docs as dynamic;

                            return  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemdescription(itemdes: snap[index]['itemdescription'], itemprice: snap[index]['itemprice'], itemname: snap[index]['itemTitle'], itemurl: snap[index]['itemurl'],itemId: snap[index]['itemId'],iteminfo: snap[index]['itemInfo'],sellerId: widget.sellerId,brandId: snap[index]['brandId'],)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          .2,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          .3,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        color: Colors.grey[300],
                                      ),
                                      // color: Colors.red,
                                      child: Hero(
                                        tag: Key(snap1[0]['itemId']),
                                        child: Image.network(
                                          snap1[0]['itemurl'],
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex:2,
                                              child: Text(
                                                snap1[0]['itemTitle'],
                                                style: const TextStyle(

                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(width: 5,),
                                            Expanded(

                                                child: Text("\$ ${snap1[0]['itemprice']}",style: const TextStyle(
                                                    color: Colors.cyan,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                       Expanded(
                                         child: Text("X "+(widget.quantity[index]).toString(),style: const  TextStyle(

                                             fontWeight: FontWeight.bold,
                                             fontSize: 18)),
                                       ),

                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(
                              child: Text("No data"),
                            );
                          }
                          ;
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
