import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';
import 'package:quick_sell/screen/review_cart_screen.dart';
import 'package:quick_sell/utils/imageUtils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/utils/count.dart';

class itemdescription extends StatefulWidget {
  final String itemurl;
  final String itemname;
  final String itemdes;
  final String itemprice;
  final String itemId;
  final String iteminfo;

  const itemdescription(
      {Key? key,
      required this.itemdes,
      required this.itemprice,
      required this.itemname,
      required this.itemurl,
      required this.itemId,
      required this.iteminfo})
      : super(key: key);

  @override
  State<itemdescription> createState() => _itemdescriptionState();
}

class _itemdescriptionState extends State<itemdescription> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        actions: [
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => reviwCartScreen()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.blueAccent,
                ),
              ),
            ),


            //Item curretnt count show above the cart

            // _itemCount != 0
            //     ? Positioned(
            //         top: 8,
            //         right: -8,
            //         left: 8,
            //         child: CircleAvatar(
            //           radius: 7,
            //           backgroundColor: Colors.green,
            //           child: Center(
            //               child: Text(
            //             _itemCount.toString(),
            //             style: TextStyle(color: Colors.white, fontSize: 11),
            //           )),
            //         ))
            //     : Container(),
          ])
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: Key(widget.itemId),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    // color: Colors.grey,
                    child: Center(
                        child: Image.network(
                  widget.itemurl,
                  height: MediaQuery.of(context).size.height * .35,
                ))),
              )),
          Expanded(
              child: VxArc(
            height: 25,
            arcType: VxArcType.CONVEY,
            edge: VxEdge.TOP,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: Column(
                  children: [
                    Text(widget.itemname),
                    Text(widget.itemdes),
                  ],
                ),
              ),
            ),
          ))
        ],
      )),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " \$ ${widget.itemprice}",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child:count(itemprice:widget.itemprice ,itemId:widget.itemId ,iteminfo:widget.iteminfo ,itemname:widget.itemname ,itemurl:widget.itemurl ,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
