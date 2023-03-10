import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_sell/screen/item_description_screen.dart';
import 'package:quick_sell/utils/imageUtils.dart';

import '../utils/color.dart';

class brandItem extends StatefulWidget {
  final String sellerId;
  final DocumentSnapshot snap;
  const brandItem({Key? key, required this.snap, required this.sellerId})
      : super(key: key);

  @override
  State<brandItem> createState() => _brandItemState();
}

class _brandItemState extends State<brandItem> {
  int _itemCount=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("QuickSell"),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: linear),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Card(
                    elevation: 20,
                    shadowColor: Colors.grey,
                    color: Colors.blue[400],
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * .9,
                        child: Center(
                            child: Text(
                          "${widget.snap['brandTitle']}'s Items",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('sellers')
                    .doc(widget.sellerId)
                    .collection('brand')
                    .doc(widget.snap['brandId'])
                    .collection('item')
                    .orderBy('publiseddate', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final snap = (snapshot.data!.docs) as dynamic;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Card(
                            // color: Colors.black54,
                            shadowColor: Colors.grey,
                            elevation: 20,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>itemdescription(itemdes: snap[index]['itemdescription'], itemprice: snap[index]['itemprice'], itemname: snap[index]['itemTitle'], itemurl: snap[index]['itemurl'],itemId: snap[index]['itemId'],iteminfo: snap[index]['itemInfo'],)));
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
                                            tag: Key(snap[index]['itemId']),
                                            child: Image.network(
                                              snap[index]['itemurl'],
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
                                          Text(
                                            snap[index]['itemTitle'],
                                            style: const TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            snap[index]['itemInfo'],
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ButtonBar(
                                            alignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "\$ ${snap[index]['itemprice']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child:
                                                _itemCount==0?InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      _itemCount++;
                                                    });
                                                  },
                                                    child: const Center(child:Text("Buy",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),))):
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        print(_itemCount);
                                                        if(_itemCount>0)
                                                          {
                                                            setState(() {
                                                              _itemCount--;
                                                            });

                                                          }
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                     Text(_itemCount.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                                                    IconButton(
                                                      onPressed: () {
                                                        _itemCount>9?showSnakbar("You can Oder above 10", context):setState((){
                                                          _itemCount++;

                                                        });

                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snap.length,
                    );
                  } else {
                    return const Center(
                      child: Text("No Brand Exists"),
                    );
                  }
                },
              ),
            ),
          ],
        ),

      ),
    );
  }
}
