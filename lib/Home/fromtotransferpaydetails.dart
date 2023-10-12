import 'package:bankapp/Home/fromaccounttoaccountscreeen.dart';
import 'package:bankapp/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FromToTransferPayDetailsScreen extends StatefulWidget {
  final String fromAccountUserName;
  final String accountTitle;
  final String bankName;
  final String imagePath;
  final String accountNumber;
  final String receiverAccountNumber;
  final String nickName;
  final String amount;
  final double userBalance;

  FromToTransferPayDetailsScreen({
    required this.fromAccountUserName,
    required this.accountTitle,
    required this.bankName,
    required this.imagePath,
    required this.accountNumber,
    required this.nickName,
    required this.amount,
    required this.receiverAccountNumber,
    required this.userBalance,
  });

  @override
  State<FromToTransferPayDetailsScreen> createState() =>
      _FromToTransferPayDetailsScreenState();
}

class _FromToTransferPayDetailsScreenState
    extends State<FromToTransferPayDetailsScreen> {
  late double userBalance;

  @override
  void initState() {
    super.initState();
    userBalance = widget.userBalance;
  }
  Future<double> getReceiverBalanceFromFirestore() async {
    // Replace this with code to fetch the receiver's balance from Firestore
    try {
      DocumentSnapshot receiverData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverAccountNumber)
          .get();

      if (receiverData.exists) {
        return receiverData['balance'].toDouble();
      }
    } catch (e) {
      print('Error fetching receiver balance: $e');
    }
    return -1; // Return a negative value to indicate an error
  }
  void updateReceiverBalanceInFirestore(double newBalance) {
    // Replace this with code to update the receiver's balance in Firestore
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.receiverAccountNumber)
          .update({'balance': newBalance});
    } catch (e) {
      print('Error updating receiver balance: $e');
    }
  }
  void deductAmountFromBalance(double amount) {
    userBalance -= amount;
    updateBalanceInFirestore(userBalance);
  }

  void updateBalanceInFirestore(double newBalance) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Update the balance in Firestore for the current user
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'balancePKR': newBalance});
    }
  }

  Future<void> saveTransferDetailsToFirestore(double totalTransferredAmount) async {
    try {
      final CollectionReference transfersCollection =
      FirebaseFirestore.instance.collection('transaction');

      Map<String, dynamic> transferData = {
        'fromAccountUserName': widget.fromAccountUserName,
        'accountTitle': widget.accountTitle,
        'bankName': widget.bankName,
        'userAccountNumber': widget.accountNumber,
        'receiverAccountNumber': widget.receiverAccountNumber,
        'nickName': widget.nickName,
        'amount': widget.amount,
        'totalAmount': totalTransferredAmount,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await transfersCollection.add(transferData);

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Payment Successful'),
          backgroundColor: Colors.white,
        ),
      );
    } catch (e) {
      print('Error saving transfer details: $e');
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
                          onPressed: () {},
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
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications, color: Colors.orange),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.power_settings_new,
                              color: Colors.orange),
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
                          color: Colors.orange,
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
                            widget.imagePath,
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
                          style: TextStyle(color: Colors.orange, fontSize: 15),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'AccountTitle',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.accountTitle,
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the right text
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
                                        color: Colors
                                            .white, // Use the specified color for the right text
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
                                      'Nick',
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.nickName,
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the right text
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
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Transfer Details',
                          style: TextStyle(color: Colors.orange, fontSize: 15),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.amount,
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the right text
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
                                        color: Colors
                                            .white, // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Rs.0.00',
                                      style: TextStyle(
                                        color: Colors
                                            .redAccent, // Use the specified color for the right text
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
                                        color: Colors
                                            .white, // Use the specified color for the left text
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      widget.amount,
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Use the specified color for the right text
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
                              backgroundColor: Colors.grey),
                          onPressed: () {},
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
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () async {
                          double amountToTransfer = double.parse(widget.amount);

                          if (amountToTransfer > 0 && amountToTransfer <= widget.userBalance) {

                            deductAmountFromBalance(amountToTransfer);
                            saveTransferDetailsToFirestore(amountToTransfer);
                            // Deduct the entered amount from the sender's balance
                            deductAmountFromBalance(amountToTransfer);

                            // Add the transfer amount to the receiver's balance
                            double receiverBalance = await getReceiverBalanceFromFirestore();

                            // receiverBalance += amount;
                            updateReceiverBalanceInFirestore(receiverBalance);
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