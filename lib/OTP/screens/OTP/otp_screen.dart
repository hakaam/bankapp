import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print("Verification failed: ${authException.message}");
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      this.verificationId = verificationId;
      print("SMS code sent to $phoneNumber"); // Print the phone number
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OtpScreen(verificationId: verificationId, phoneNumber: phoneNumber),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your phone number (e.g., +923467433714)',
                ),
                onChanged: (value) {
                  // Handle phone number input
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final phoneNumber = '+92' + // Country code
                    '3467433714'; // Subscriber number
                print("Verifying phone number: $phoneNumber");
                verifyPhoneNumber(phoneNumber);
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  OtpScreen({required this.verificationId, required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();

  void signInWithOTP(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print("Verifying OTP for phone number: ${widget.phoneNumber}");
                signInWithOTP(_otpController.text);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Phone number authentication successful!'),
      ),
    );
  }
}
