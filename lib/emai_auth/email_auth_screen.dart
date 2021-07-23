import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';

class EmailAuthScreen extends StatefulWidget {
  static const routeName = '/email-auth';

  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = 'Test';
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP send");
    } else {
      print("OTP didn't send");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("Verified");
    } else {
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Email Auth",
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/1.png',
              height: 200,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: "Email",
                        suffixIcon: TextButton(
                          onPressed: () => sendOTP(),
                          child: Text("Send OTP"),
                        )),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter OTP', labelText: "OTP"),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      onPressed: () => verifyOTP(), child: Text('Verify OTP'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
