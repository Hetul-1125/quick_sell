import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quick_sell/provider/review_cart_provider.dart';
import 'package:quick_sell/utils/imageUtils.dart';
import 'package:quick_sell/widgets/textfom_intput.dart';
import 'package:uuid/uuid.dart';

class saveAddress extends StatefulWidget {
  const saveAddress({Key? key}) : super(key: key);

  @override
  State<saveAddress> createState() => _saveAddressState();
}

class _saveAddressState extends State<saveAddress> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _streetcontroller = TextEditingController();
  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _statecontroller = TextEditingController();
  final TextEditingController _housenumbercontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  uploadAddressdata(
      {required String name,
      required String street,
      required String city,
      required String state,
      required String housenumber,
      required String phonenumber}) async {
    String completaddress=street+', '+housenumber+', '+city+', '+state;
    var addressId=Uuid().v1();
    await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).collection('useraddress').doc(addressId).set({
      'name':name,
      'street':street,
      'city':city,
      'state':state,
      'housenumber':housenumber,
      'phonenumber':phonenumber,
      'completaddress':completaddress,
      'addressId':addressId,
      'addressdatepublised':DateTime.now(),
    }).then((value){
            // Fluttertoast.showToast(msg: "Your address add Successfully.");
      showSnakbar("Your address added Successfully.", context);
            formkey.currentState!.reset();
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phonenumbercontroller.dispose();
    _housenumbercontroller.dispose();
    _statecontroller.dispose();
    _streetcontroller.dispose();
    _citycontroller.dispose();
    _namecontroller.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("QuickSell"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formkey.currentState!.validate()) {
            uploadAddressdata(
                name: _namecontroller.text,
                street: _streetcontroller.text,
                city: _citycontroller.text,
                state: _statecontroller.text,
                housenumber: _housenumbercontroller.text.toString(),
                phonenumber: _phonenumbercontroller.text.toString());
          }
        },
        label: const Text("Save Address"),
        icon: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Save New Address :",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    textformInput(
                        textEditingController: _namecontroller,
                        hinttext: "Name",
                        inputtype: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    textformInput(
                        textEditingController: _phonenumbercontroller,
                        hinttext: "Phone Number",
                        inputtype: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    textformInput(
                        textEditingController: _streetcontroller,
                        hinttext: "Street Number",
                        inputtype: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    textformInput(
                        textEditingController: _housenumbercontroller,
                        hinttext: "Flat/House Number",
                        inputtype: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    textformInput(
                        textEditingController: _citycontroller,
                        hinttext: "City",
                        inputtype: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    textformInput(
                        textEditingController: _statecontroller,
                        hinttext: "State",
                        inputtype: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
