import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uniqueNumber = generateUniqueNumber();

      // Create a new user document in Firestore with additional information
      await _firestore.collection('users').doc(authResult.user!.uid).set({
        'name': name,
        'email': email,
        'balance': 500, // Default balance
        'beneficiaries': [], // Empty beneficiaries array
        'accountNumber': uniqueNumber, // Add the unique number to Firestore
        


      });
    } catch (e) {
      throw e;
    }
  }

  String generateUniqueNumber() {
    Random random = Random();
    String uniqueNumber = DateTime.now().millisecondsSinceEpoch.toString();

    while (uniqueNumber.length < 14) {
      uniqueNumber += random.nextInt(10).toString();
    }

    return uniqueNumber.substring(0, 14); // Ensure it's exactly 14 digits
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
