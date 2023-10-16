import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({
    Key? key,
  });

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  AuthProvider authProvider = AuthProvider();
  List<Map<String, dynamic>> transactionData = [];

  @override
  void initState() {
    super.initState();
    fetchTransactionData();
  }

  void fetchTransactionData() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final String? currentUserId = currentUser?.uid;
    print("Current user ID: $currentUserId");

    if (currentUserId != null) {
      FirebaseFirestore.instance
          .collection('transaction')
          .where('userId', isEqualTo: currentUserId)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          List<Map<String, dynamic>> transactions = [];
          querySnapshot.docs.forEach((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            transactions.add(data);
          });

          print("Number of transactions: ${transactions.length}");

          setState(() {
            transactionData = transactions;
          });
        } else {
          print("No transactions found for the current user");
        }
      }).catchError((error) {
        print('Error fetching data: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime(2023, 10, 10);
    final DateTime endDate = DateTime(2023, 10, 15).add(Duration(days: 1)); // Include the end of the day

    final List<Map<String, dynamic>> filteredTransactions = transactionData;


    print("Filtered Transactions: $filteredTransactions");

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
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
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'My Account',
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
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                                    (Route<dynamic> route) => false,
                              );
                            } catch (e) {}
                          },
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Material(
                color: Colors.white,
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Center(
                          child: Text(
                            '${filteredTransactions.isNotEmpty ? _formatTimestamp(filteredTransactions[0]['timestamp']) : ''}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              for (var data in filteredTransactions)
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Money Transferred to',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [

                              Text(
                                '${data['senderTitle'].toString().toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                ' ${data['receiverTitle'].toString().toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${data['bankName'].toString().toUpperCase()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        'Rs. ${double.parse(data['transactionAmount']).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final String formattedDate =
    DateFormat('E, d MMM yyyy', 'en_US').format(dateTime);
    return formattedDate;
  }
}
