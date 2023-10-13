import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBeneficiaryDetailsScreen extends StatefulWidget {
  final String bankName;
  final String accountNumber;
  final String imageUrl;
  final String username; // Add this property

  AddBeneficiaryDetailsScreen({
    required this.bankName,
    required this.imageUrl,
    required this.username,
    required this.accountNumber,
  });

  @override
  State<AddBeneficiaryDetailsScreen> createState() =>
      _AddBeneficiaryDetailsScreenState();
}

class _AddBeneficiaryDetailsScreenState
    extends State<AddBeneficiaryDetailsScreen> {
  // Define a function to handle the click action
  final TextEditingController nickNameController = TextEditingController();

  Future<void> storeBeneficiaryDetails() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Create a reference to the beneficiary collection
      final beneficiaryRef =
          FirebaseFirestore.instance.collection("beneficiaries");

      // Add the beneficiary details to Firestore
      await beneficiaryRef.add({
        'userId': userId,
        'bankName': widget.bankName,
        'imageUrl': widget.imageUrl,
        'nickName': nickNameController.text,
        'receiverAccountNumber': widget.accountNumber,
        'userName': widget.username
      });

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      print("Error storing beneficiary details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Row(
        children: [
          Flexible(
            child: Container(
              height: 58,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Flexible(
            child: Container(
              height: 58,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600),
                  onPressed: storeBeneficiaryDetails,
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 65,
                color: Colors.blue.shade600,
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.power_settings_new,
                              color: Colors.white),
                        ),
                      ],
                    ),
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
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            widget.imageUrl, // Use the passed imageUrl
                            scale: 3.5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.bankName,
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
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm following beneficiary details',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors
                              .grey, // Change this color to your desired border color
                          width: 2.0, // Change the width as needed
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Account Title',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${widget.username}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Bank Name',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  widget.bankName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Branch',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'College Road Lahore',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: nickNameController,
                      style: TextStyle(color: Colors.white), // Text color
                      decoration: InputDecoration(
                        hintText: 'Type NickName',
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
            ],
          ),
        ),
      ),
    );
  }
}
