import 'package:calender/searchBar/serach_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class PhoneAuthenticate extends StatefulWidget {
  const PhoneAuthenticate({Key? key}) : super(key: key);

  @override
  _PhoneAuthenticateState createState() => _PhoneAuthenticateState();
}

class _PhoneAuthenticateState extends State<PhoneAuthenticate> {
  final _numberController = TextEditingController();
  final _codeController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn = false;
  bool sendOtp = false;
  late String uid;
  late String _verificationId;

  void _verifyOTP() async {
    final credential = await PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _codeController.text);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          isLoggedIn = true;
          uid = FirebaseAuth.instance.currentUser!.uid;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _sentOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _numberController.text,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

    setState(() {
      sendOtp = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception);
    setState(() {
      isLoggedIn = false;
      sendOtp = false;
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _verificationId = verificationId;
      sendOtp = true;
    });
  }

  void codeSent(String verificationId, [int? code]) async {
    setState(() {
      _verificationId = verificationId;
      sendOtp = true;
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);

    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isLoggedIn = true;
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
    } else {
      print("Failed to sign in");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoggedIn
          ? Container(
              child: Center(
                child: Text("Logged In"),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: size.height * 0.4),
              child: sendOtp
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _codeController,
                          decoration: InputDecoration(
                            hintText: "Enter OTP",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: _verifyOTP, child: Text("Sent OTP"))
                      ],
                    )
                  : Column(children: [
                      Text(
                        "Phone Authentication",
                        style: TextStyle(color: Colors.purple),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _numberController,
                      ),
                      ElevatedButton(
                          onPressed: _sentOTP,
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ))
                    ]),
            ),
    );
  }
}
