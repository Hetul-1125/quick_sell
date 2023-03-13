import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';
import 'package:uuid/uuid.dart';

import 'home_screen.dart';

class placeOrder extends StatefulWidget {
  final String sellerId;
  final String total;
  final String addressId;
  final String brandId;
  const placeOrder(
      {Key? key,
      required this.addressId,
      required this.total,
      required this.sellerId,
      required this.brandId})
      : super(key: key);

  @override
  State<placeOrder> createState() => _placeOrderState();
}

class _placeOrderState extends State<placeOrder> {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  ReviewcartProvider? _reviewcartProvider;
  String orderID=Uuid().v1();
  saveOrderDetailsForUser()async {
    await _firestore.collection('user').doc(_auth.currentUser!.uid).collection(
        'orders').doc(orderID).set({
      'addressId': widget.addressId,
      'total': _reviewcartProvider!.gettotal,
      'orderBy': _auth.currentUser!.uid,
      'productIds': _reviewcartProvider!.cartitem,
      'productquantitys':_reviewcartProvider!.productquantity,
      'placeorderTime': DateTime.now(),
      'orederId': orderID,
      'isSuccess': true,
      'status': 'normal',


    });
  }
  saveOrderDetailsForseller()async{
        await _firestore.collection('orders').doc(orderID).set({
      'addressId':widget.addressId,
      'total':_reviewcartProvider!.gettotal,
      'orderBy':_auth.currentUser!.uid,
      'productIds':_reviewcartProvider!.cartitem,
          'productquantitys':_reviewcartProvider!.productquantity,
      'placeorderTime':DateTime.now(),
      'orederId':orderID,
      'isSuccess':true,
      'status':'normal',


    }).whenComplete(() {
          _reviewcartProvider!.clearReviewCart();
          Fluttertoast.showToast(msg: "Congratulations,Order has been placed successfully.");
        });
  }

  @override
  Widget build(BuildContext context) {
    _reviewcartProvider = Provider.of(context, listen: false);
    print(_reviewcartProvider!.getcartitem);
    print(_reviewcartProvider!.gettotal);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/delivery.png'),
          TextButton(
            onPressed: () {
              saveOrderDetailsForUser();
              saveOrderDetailsForseller();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context)=>const homescreen()));

            },
            child: Container(
              height: MediaQuery.of(context).size.height * .045,
              width: MediaQuery.of(context).size.width * .35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blueAccent,
              ),
              child: const Center(
                  child: Text(
                "Place Order Now",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
