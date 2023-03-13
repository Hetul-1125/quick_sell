import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/screen/add_delivery_addess/add_delivery_address_screen.dart';
import 'package:quick_sell/screen/home_screen.dart';

import '../provider/review_cart_provider.dart';
import '../utils/imageUtils.dart';

class reviwCartScreen extends StatefulWidget {
  final String sellerId;
  final String brandId;
  const reviwCartScreen({Key? key,required this.sellerId,required this.brandId}) : super(key: key);

  @override
  State<reviwCartScreen> createState() => _reviwCartScreenState();
}

class _reviwCartScreenState extends State<reviwCartScreen> {
  ReviewcartProvider?_reviewcartProvider;

  @override
  Widget build(BuildContext context) {
    _reviewcartProvider=Provider.of(context,listen: false);
    // _reviewcartProvider!.getTotal();
    return Scaffold(
      appBar: AppBar(
        title: Text("Review cart"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('reviewcartdata')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!.docs as dynamic;
            return ListView.builder(
              itemBuilder: (context, index) {

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Card(
                    // color: Colors.black54,
                    shadowColor: Colors.grey,
                    elevation: 20,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: MediaQuery.of(context).size.height * .2,
                                width: MediaQuery.of(context).size.width * .3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300],
                                ),
                                // color: Colors.red,
                                child: Image.network(
                                  snap[index]['productimage'],
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snap[index]['productname'],
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Price : ',style: TextStyle(fontSize: 20),),
                                      Text(
                                        "\$${snap[index]['productprice']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text('Quantity :',style: TextStyle(fontSize: 20),),
                                      Text(
                                        "${snap[index]['productquantity']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: snap.length,
            );
          } else {
            return const Center(
              child: Text(
                "No item is selectecd",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // '100',
                " \$ ${_reviewcartProvider!.gettotal}",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
             TextButton(onPressed: (){
               showDialog<String>(
                 context: context,
                 builder: (BuildContext context) =>
                     AlertDialog(
                       title: const Text('Confirm'),
                       content: const Text(
                           'Do you want to delet Items in Cart ?'),
                       actions: <Widget>[
                         TextButton(
                           onPressed: () =>
                               Navigator.of(context)
                                   .pop(),
                           child: const Text(
                             'No',
                             style: TextStyle(
                                 color: Colors.green,
                                 fontWeight:
                                 FontWeight.bold),
                           ),
                         ),
                         TextButton(
                           onPressed: () {
                                    _reviewcartProvider!.clearReviewCart();
                             showSnakbar(
                                 "Items deleted Successfuly",
                                 context);
                             Navigator.of(context)
                                 .pushReplacement(MaterialPageRoute(builder: (context)=>const homescreen()));
                           },
                           child: const Text(
                             'Yes',
                             style: TextStyle(
                                 color: Colors.red,
                                 fontWeight:
                                 FontWeight.bold),
                           ),
                         ),
                       ],
                     ),
               );

             }, child:Container(
               height: MediaQuery.of(context).size.height*.039,
               width: MediaQuery.of(context).size.width*.3,
               decoration: BoxDecoration(
                 color: Colors.blueAccent,
                 borderRadius: BorderRadius.circular(20)
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: const [
                   Icon(Icons.delete_outline_outlined,size: 18,color: Colors.red,),
                   Center(child: Text("Clear Cart",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w800),)),
                 ],
               ),
             )),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addDeliveryAddress(total:_reviewcartProvider!.getcartTotal().toString(),sellerId: widget.sellerId,brandId: widget.brandId,)));
              }, child:Container(
                height: MediaQuery.of(context).size.height*.039,
                width: MediaQuery.of(context).size.width*.3,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.arrow_forward_ios,size: 18,color: Colors.white,),
                    Center(child: Text("Check Out",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w800),)),
                  ],
                ),
              ))

            ],
          ),
        )
    );
  }
}
