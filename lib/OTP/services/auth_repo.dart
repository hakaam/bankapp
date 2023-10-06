import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<void> submitPhoneNumber(String phoneNumber);
  void verificationCompleted(PhoneAuthCredential credential);
  void verificationFailed(FirebaseAuthException e);
  void codeSent(String verificationId, int? resendToken);
  void codeAutoRetrievalTimeout(String verificationId);
  Future<void> submitOTP(String smsCode);
  Future<void> signin(PhoneAuthCredential credential);
  Future<void> signOut();
  String gettingNumber(String option);
  User getLoggedInUser();
}
