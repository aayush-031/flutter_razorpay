import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;
  TextEditingController textEditingController= new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay =new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,handlerExternalWallet);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
  void openChekout(){
    var options= {
      "key": "rzp_test_rC1Rgv23xkAx5M" ,
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "Sample App",
      "description" : "Payment for the some random product",
      "prefill":{
        "contact" : "2323232543",
        "email" : "asd@gmail.com"
      },
      "external" :{
        "wallets" : ["paytm"]
      }
    };
    try{
         razorpay.open(options);
    }
    catch(e){
      print(e.toString());
    }
  }
  void handlerPaymentSucess() {
   print("Payment Successful");
   Toast.show("Payment Successful", context);
  }

  void handlerErrorFailure() {
    print("Payment Failed");
    Toast.show("Payment Failed", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razor Pay"),),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "amount to pay"
              ),
            ),
            SizedBox(height: 16,),
           ElevatedButton(
             onPressed: (){
             openChekout();
             },
             child: Text("Donate Now",
              style: TextStyle(
              color: Colors.white
             ),)
           )
          ],
    ),
      ),
    );
    }
  }

