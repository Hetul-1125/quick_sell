import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_sell/screen/brand_screen.dart';

import 'package:quick_sell/utils/color.dart';
import 'package:quick_sell/widgets/drawer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(

        title: const Text("QuickSell"),
        backgroundColor: Colors.cyan,
      ),
      drawer: const customdrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(

                  height: MediaQuery.of(context).size.height * .2,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  'slider/1.jpg',
                  'slider/2.jpg',
                  'slider/3.jpg',
                  'slider/4.jpg',
                  'slider/5.jpg',
                  'slider/6.jpg',
                  'slider/7.jpg',
                  'slider/8.jpg',
                  'slider/9.jpg',
                  'slider/10.jpg',
                  'slider/11.jpg',
                  'slider/12.jpg',
                  'slider/13.jpg',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              i,
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('sellers')
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
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                            child: Card(

                              // color: Colors.black54,
                              shadowColor: Colors.grey,
                              elevation: 20,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>brandScreen(sellerId: snap[index]['uid'],sellername: snap[index]['username'],)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height: MediaQuery.of(context).size.height * .3,
                                      width: MediaQuery.of(context).size.width,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(40),
                                          child: Image.network(
                                            snap[index]['photourl'],
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(height: 1,),
                                  Container(
                                    child: Text(snap[index]['username'],style: const TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 18),),
                                  ),
                                  const SizedBox(height: 1,),
                                  SmoothStarRating(
                                    starCount: 5,
                                    color: Colors.blueAccent  ,
                                    size: 16,
                                    borderColor: Colors.blueAccent,
                                    // rating: snap['rating']==null?0.0:double.parse(snap['rating']),
                                  ),
                                  const SizedBox(height: 20,),

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
