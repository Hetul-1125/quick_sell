import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';
import 'package:quick_sell/screen/add_delivery_addess/saveaddress_screen.dart';
import 'package:quick_sell/screen/placeorder_screen.dart';

class addDeliveryAddress extends StatefulWidget {
  final String total;
  final String sellerId;
  final String brandId;
  const addDeliveryAddress(
      {Key? key,
      required this.total,
      required this.brandId,
      required this.sellerId})
      : super(key: key);

  @override
  State<addDeliveryAddress> createState() => _addDeliveryAddressState();
}

class _addDeliveryAddressState extends State<addDeliveryAddress> {
  int select = 0;
  ReviewcartProvider? _reviewcartProvider;
  @override
  Widget build(BuildContext context) {
    _reviewcartProvider = Provider.of(context, listen: false);
    _reviewcartProvider!.getreviewCartitemId();
    _reviewcartProvider!.getcartTotal();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("QuickSell"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => saveAddress()));
        },
        label: const Text("Add New Address"),
        icon: const Icon(Icons.location_on_outlined),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('useraddress')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs as dynamic;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.black,
                    child: Row(
                      children: [
                        Radio(
                            activeColor: Colors.blueAccent,
                            value: select,
                            groupValue: index,
                            onChanged: (value) {
                              setState(() {
                                // select = index;
                                select = index;
                              });
                            }),

                        // RadioListTile(value: index, groupValue:1, onChanged:(value){}),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Name :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Phone Number :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Address :',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snap[index]['name'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snap[index]['phonenumber'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snap[index]['completaddress'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                select == index
                                    ? TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      placeOrder(
                                                        addressId: snap[index]
                                                            ['addressId'],
                                                        total: widget.total,
                                                        sellerId:
                                                            widget.sellerId,
                                                        brandId: widget.brandId,
                                                      )));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .035,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .25,
                                          decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                              child: Text(
                                            "Procced",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          )),
                                        ))
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snap.length,
            );
          } else {
            return Center(
              child: Text("No address add"),
            );
          }
        },
      ),
    );
  }
}
