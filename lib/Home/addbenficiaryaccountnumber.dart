import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addbeneficiarydetailscreen.dart';

class AddBeneficiaryAccountNumberScreen extends StatefulWidget {
  final String bankName;
  final String imageUrl;

  AddBeneficiaryAccountNumberScreen({
    required this.bankName,
    required this.imageUrl,
  });

  @override
  State<AddBeneficiaryAccountNumberScreen> createState() =>
      _AddBeneficiaryAccountNumberScreenState();
}

class _AddBeneficiaryAccountNumberScreenState
    extends State<AddBeneficiaryAccountNumberScreen> {
  TextEditingController accountNumberController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _checkAccountNumberExists(String accountNumber) async {
    try {
      CollectionReference users = firestore.collection('users');

      QuerySnapshot querySnapshot =
          await users.where('accountNumber', isEqualTo: accountNumber).get();

      if (querySnapshot.docs.isNotEmpty) {
        String username = querySnapshot.docs[0][
            'name'];

        // Now, navigate to the next screen and pass the username
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AddBeneficiaryDetailsScreen(
              bankName: widget.bankName,
              imageUrl: widget.imageUrl,
              username: username, // Pass the fetched username
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Account number not found.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error checking account number: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 65,
                color: Colors.purple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(
                                context); // Go back to the previous screen
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Send Money',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Rest of your AppBar content
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Add Beneficiary',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                50), // You can adjust the radius as needed
                            child: Image.network(
                              widget.imageUrl, // Use the passed imageUrl
                              scale: 2,
                              width: 50, // Set your desired width
                              height: 50, // Set your desired height
                              fit: BoxFit
                                  .cover, // You can adjust the fit as needed
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.bankName, // Use the passed bankName
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: accountNumberController,
                      style: TextStyle(color: Colors.white), // Text color
                      decoration: InputDecoration(
                        hintText: 'Account Number/IBAN',
                        helperText:
                            "PLEASE ENTER MEEZAN BANK 13/14\nDIGIT ACCOUNT NUMBER",
                        helperStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .white, // Change this color to your desired underline color
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .white, // Change this color to your desired underline color
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 58,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    String accountNumber = accountNumberController.text.trim();

                    if (accountNumber.isNotEmpty) {
                      _checkAccountNumberExists(accountNumber);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter an account number.'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
