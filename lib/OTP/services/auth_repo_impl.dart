import 'package:firebase_auth/firebase_auth.dart';

import 'auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  PhoneAuthCredential? credential;
  late String verificationId;
  @override
  void codeAutoRetrievalTimeout(String verificationId) {
    print('Code Auto Retrieval');
  }

  @override
  void codeSent(String verificationId, int? resendToken) {
    print('Code Sent');
    this.verificationId = verificationId;
  }

  @override
  User getLoggedInUser() {
    final fireBaseUser = fireBaseAuth.currentUser;

    return fireBaseUser!;
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signin(PhoneAuthCredential credential) async {
    try {
      await fireBaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> submitOTP(String smsCode) async {
    credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await signin(credential!);
  }

  @override
  Future<void> submitPhoneNumber(String phoneNumber) async {
    await fireBaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(
        seconds: 14,
      ),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  void verificationCompleted(PhoneAuthCredential credential) async {
    await signin(credential);
  }

  @override
  void verificationFailed(FirebaseAuthException e) {
    print('Verified Failed');
  }

  @override
  String gettingNumber(String options) {
    switch (options) {
      case '🇸🇦':
        {
          return '+966';
        }

      case '🇦🇪':
        {
          return '+971';
        }

      default:
        {
          return '+2';
        }
    }
  }
}
