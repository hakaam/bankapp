import 'package:bankapp/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';

class FromToTransferPayDetailsCharitiesScreen extends StatefulWidget {
  final String fromAccountUserName;
  final String charityName;
  final String charityImgUrl;
  final String accountNumber;
  final String amount;
  final double userBalance;

  FromToTransferPayDetailsCharitiesScreen({
    required this.fromAccountUserName,
    required this.charityName,
    required this.charityImgUrl,
    required this.accountNumber,
    required this.amount,
    required this.userBalance,
  });

  @override
  State<FromToTransferPayDetailsCharitiesScreen> createState() =>
      _FromToTransferPayDetailsCharitiesScreenState();
}

class _FromToTransferPayDetailsCharitiesScreenState
    extends State<FromToTransferPayDetailsCharitiesScreen> {
  AuthProvider authProvider = AuthProvider();

  late double userBalance;

  @override
  void initState() {
    super.initState();
    userBalance = widget.userBalance;
  }

  // Future<double> getReceiverBalanceFromFirestore() async {
  //   // Replace this with code to fetch the receiver's balance from Firestore
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //     await FirebaseFirestore.instance.collection('users').get();
  //
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
  //     in querySnapshot.docs) {
  //       Map<String, dynamic> data = docSnapshot.data();
  //       print("data: $data");
  //       if (data.containsKey('accountNumber') &&
  //           data['accountNumber'] == widget.receiverAccountNumber) {
  //         return data['balance${Common.currency}'];
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching receiver balance: $e');
  //   }
  //   return -1;
  // }

  // void updateReceiverBalanceInFirestore(double newBalance) async {
  //   // Replace this with code to update the receiver's balance in Firestore
  //
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //     await FirebaseFirestore.instance.collection('users').get();
  //
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
  //     in querySnapshot.docs) {
  //       Map<String, dynamic> data = docSnapshot.data();
  //       if (data.containsKey('accountNumber') &&
  //           data['accountNumber'] == widget.receiverAccountNumber) {
  //         DocumentReference docRef = FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(docSnapshot.id);
  //         await docRef.update({'balance${Common.currency}': newBalance});
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching receiver balance: $e');
  //   }
  // }

  void deductAmountFromBalance(double amount) {
    userBalance -= amount;
    print("userBalance: $userBalance");
    updateBalanceInFirestore(userBalance);
  }

  void updateBalanceInFirestore(double newBalance) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    print("newBalance: ${newBalance}");
    print(currentUser?.uid);
    print(Common.currency);

    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'balance${Common.currency}': newBalance});
    }
  }

  Future<void> saveTransferDetailsToFirestore(
      double transactionAmount, double remainingBalance) async {
    try {
      final CollectionReference transfersCollection =
          FirebaseFirestore.instance.collection('charitytransactions');

      // Retrieve the current user's UID
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        Map<String, dynamic> transferData = {
          'userId': currentUser.uid, // Add the userId
          'senderTitle': widget.fromAccountUserName,
          'userAccountNumber': widget.accountNumber,
          'transactionAmount': widget.amount,
          'remainingBalance': remainingBalance,
          'charityName': widget.charityName,
          'timestamp': FieldValue.serverTimestamp(),
        };

        await transfersCollection.add(transferData);

        // showDialog<String>(
        //   context: context,
        //   builder: (BuildContext context) => AlertDialog(
        //     title: const Text('Payment Successful'),
        //     backgroundColor: Colors.white,
        //   ),
        // );
      } else {
        // Handle the case where the user is not authenticated
        print('User not authenticated');
      }
    } catch (e) {
      print('Error saving transfer details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Container(
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
                            Navigator.pop(context);
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
                          onPressed: () async {
                            try {
                              await authProvider.signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()),
                              );
                            } catch (e) {}
                          },
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
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            'https://ebanking.meezanbank.com/AmbitRetailFrontEnd/images/new-login-logo.png',
                            scale: 3.5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.fromAccountUserName,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.accountNumber,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.blue.shade600,
                              // Change this color to your desired border color
                              width: 2.0, // Change the width as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Charity Name',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.charityName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          // Use the specified color for the right text
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Transfer Details',
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
                              color: Colors.blue.shade600,
                              // Change this color to your desired border color
                              width: 2.0, // Change the width as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.amount,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // Use the specified color for the right text
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bank Charges',
                                      style: TextStyle(
                                        color: Colors.white,
                                        // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Rs.0.00',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        // Use the specified color for the right text
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                        color: Colors.white,
                                        // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.amount,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // Use the specified color for the right text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade600,
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
                          backgroundColor: Colors.blue.shade600,
                        ),
                        onPressed: () async {
                          double amountToTransfer = double.parse(widget.amount);

                          if (amountToTransfer > 0 &&
                              amountToTransfer <= widget.userBalance) {
                            deductAmountFromBalance(amountToTransfer);
                            saveTransferDetailsToFirestore(amountToTransfer,
                                widget.userBalance - amountToTransfer);

                            double receiverBalance =
                                // await getReceiverBalanceFromFirestore();
                                // receiverBalance += amountToTransfer;

                                // updateReceiverBalanceInFirestore(receiverBalance);

                                Common.userBalances[Common.currency] =
                                    widget.userBalance - amountToTransfer;

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Transaction Successful'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Insufficient Balance'),
                                  content: Text(
                                    'Your balance is not sufficient for this transaction.',
                                  ),
                                  actions: [
                                    TextButton(
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
                          'Pay Now',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
