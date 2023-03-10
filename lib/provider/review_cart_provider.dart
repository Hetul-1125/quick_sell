import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ReviewcartProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  additemToReviewCart(
      {required String productname,
      required String productimage,
      required String productId,
      required int productprice,
        required String productinfo,
      required int quantity,
      bool? isAdd = true}) async {
    await _firestore
        .collection('user')
        .doc(_auth.currentUser!.uid)
        .collection('reviewcartdata')
        .doc(productId)
        .set({
      "productname": productname,
      "productimage": productimage,
      "productprice": productprice,
      "productid": productId,
      "productinfo":productinfo,
      "productquantity": quantity,
      "isAdd": isAdd,
    });
  }

  //reviewcartData
  // reviewCartData()async{
  //   // await _firestore.collection('user').doc(_auth.currentUser!.uid).collection('reviewcartdata').doc()
  // }


  // updateQuantityofProduct
  updateToQuantityofItemCart(
      {required String productname,
        required String productimage,
        required String productId,
        required int productprice,
        required String productinfo,
        required int quantity,
        bool? isAdd = true}) async {
    print('quantity');
    print(quantity);
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('reviewcartdata')
        .doc(productId).update({
      "productname": productname,
      "productimage": productimage,
      "productprice": productprice,
      "productid": productId,
      "productquantity": quantity,
      "productinfo":productinfo,
      "isAdd": isAdd,

    });
   // notifyListeners();

  }
  int ?itemCount;
    //getquantity of item
  getAddQuantity({required String itemId})async  {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('reviewcartdata').doc(itemId)
        .get().then((value) {

        if(value.exists)
        {
            itemCount=value.get("productquantity");

        }
        notifyListeners();
       return itemCount;
    });
  }
  int get getcount{
    return itemCount!;
  }

  //deletitemfromReviewCart

  deletitemFromCart({required String productId}) async {

    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('reviewcartdata')
        .doc(productId)
        .delete();
    notifyListeners();
  }
  //clearReviewCart

clearReviewCart()async{
  QuerySnapshot value=await FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('reviewcartdata').get();

  notifyListeners();
}

//gettotal
  int? total;
  getcartTotal()async{
    int temp=0;
    QuerySnapshot value=await _firestore.collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('reviewcartdata').get();
    value.docs.forEach((element) {
      // int a=element.get('productprice');
      //
      // print('price'+element.get('productprice').toString());
      // print('quantity'+element.get('productquantity').toString());

      temp+=int.parse((element.get('productprice')*element.get('productquantity')).toString());
    });
    total=temp;

  }
  int get  gettotal{
    return total!;
  }



}
