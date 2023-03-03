import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/utils/color.dart';
import 'package:quick_sell/widgets/drawer_widget.dart';

import '../provider/useProvider.dart';
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace:Container(
              decoration:  BoxDecoration(
                gradient:linear
              ),
            ),
            title: const Text("QuickSell"),
          ),
          drawer:   const customdrawer(),
        ));
  }
}
