import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';

import 'imageUtils.dart';
class count extends StatefulWidget {
  final String itemurl;
  final String itemname;
  final String iteminfo;
  final String itemprice;
  final String itemId;
  final String brandId;
  final String sellerId;
  const count({Key? key,required this.iteminfo,
    required this.itemprice,
    required this.itemname,
    required this.itemurl,
    required this.itemId,
    required this.sellerId,
    required this.brandId,
  }) : super(key: key);

  @override
  State<count> createState() => _countState();
}

class _countState extends State<count> {
  ReviewcartProvider?_reviewcartProvider;
  int _itemCount=1;
  bool _isbool=false;
  getAddQuantity()async  {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('reviewcartdata').doc(widget.itemId)
        .get().then((value) {
      if(mounted)
      {

        if(value.exists)
        {
          setState(() {
            _itemCount=value.get("productquantity");
            _isbool=value.get("isAdd");
          });
        }
      }
    });
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getAddQuantity();
  // }
  @override
  Widget build(BuildContext context) {
    _reviewcartProvider=Provider.of(context,listen: false);
      getAddQuantity();
    _reviewcartProvider!.getcartTotal();
    return  Container(
      height: 40,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _isbool
          ?  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              if (_itemCount >1) {
                setState(() {
                  _itemCount--;
                });
                _reviewcartProvider!.updateToQuantityofItemCart(   productname: widget.itemname,
                    productimage: widget.itemurl,
                    productId: widget.itemId,
                    productinfo:widget.iteminfo,
                    productprice: int.parse(widget.itemprice),
                    quantity: _itemCount,
                    sellerId: widget.sellerId,
                    brandId: widget.brandId
                );
              } else {
                  setState(() {

                    _isbool=false;
                  });

                _reviewcartProvider!.deletitemFromCart(
                    productId: widget.itemId);
              }
            },
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          Text(
            _itemCount.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              if (_itemCount > 9) {
                showSnakbar(
                    "You can't order above 10 item", context);
              } else {
                setState(() {
                  _itemCount++;
                });
                _reviewcartProvider!.updateToQuantityofItemCart(   productname: widget.itemname,
                    productimage: widget.itemurl,
                    productId: widget.itemId,
                    productinfo:widget.iteminfo,
                    productprice: int.parse(widget.itemprice),
                    quantity: _itemCount,
                    sellerId: widget.sellerId,
                    brandId: widget.brandId);
              }
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ):InkWell(
          onTap: () {
            setState(() {
              _isbool=true;
            });
            _reviewcartProvider!.additemToReviewCart(
                productname: widget.itemname,
                productimage: widget.itemurl,
                productinfo:widget.iteminfo,
                productId: widget.itemId,
                productprice: int.parse(widget.itemprice),
                quantity: _itemCount,
                sellerId: widget.sellerId,
                brandId: widget.brandId

            );
          },
          child: const Center(
              child: Text(
                "Buy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )))
          ,
    );
  }
}
