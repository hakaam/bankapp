import 'package:bankapp/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  AuthProvider authProvider = AuthProvider();
  List<Map<String, dynamic>> combinedTransactions = [];
  DateTime? currentDate;

  Future<void> fetchUserBalance() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get();
        if (userDoc.exists) {
          var balancePKR = userDoc['balancePKR'];
          var balanceUSD = userDoc['balanceUSD'];
          var balanceCAD = userDoc['balanceCAD'];

          Map<String, dynamic> balances = {};
          balances["PKR"] = balancePKR;
          balances["USD"] = balanceUSD;
          balances["CAD"] = balanceCAD;
          print(
              "Logged Account Number StatementScreen: ${userDoc["accountNumber"]}");

          setState(() {
            Common.loggedInAccountNo = userDoc["accountNumber"];
            Common.userBalances = balances;
            Common.currency = "PKR";
          });
        }
      }
    } catch (e) {
      print("Error fetching user balance: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserBalance();
    fetchCombinedTransactions();
  }

  Future<void> fetchCombinedTransactions() async {
    final regularTransactions = await FirebaseFirestore.instance
        .collection('transaction')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    final charityTransactions = await FirebaseFirestore.instance
        .collection('charitytransactions')
        .get();

    final List<Map<String, dynamic>> regularTransactionList =
    regularTransactions.docs.map((transactionDoc) {
      final transaction = transactionDoc.data() as Map<String, dynamic>;
      transaction['isCharity'] =
      false;
      return transaction;
    }).toList();

    final List<Map<String, dynamic>> charityTransactionList =
    charityTransactions.docs.map((charityDoc) {
      final charityTransaction = charityDoc.data() as Map<String, dynamic>;
      charityTransaction['isCharity'] =
      true;
      return charityTransaction;
    }).toList();

    combinedTransactions = [
      ...regularTransactionList,
      ...charityTransactionList
    ];

    // Sort the combined transactions by timestamp in descending order
    combinedTransactions.sort((a, b) {
      final timestampA = (a['timestamp'] as Timestamp).toDate();
      final timestampB = (b['timestamp'] as Timestamp).toDate();
      return timestampB.compareTo(timestampA);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Custom App Bar
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
            SizedBox(height: 20,),

            // Transaction List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _buildTransactionList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransactionList() {
    if (combinedTransactions.isEmpty) {
      return [
        Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,  // You can choose the colors you prefer
            highlightColor: Colors.grey.shade100,
            child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              child: CircularProgressIndicator(
                value: 0.8,
              ),
            ),
          ),
        ),
      ];
    }

    List<Widget> transactionWidgets = [];

    for (var data in combinedTransactions) {
      final transactionDate = (data['timestamp'] as Timestamp).toDate();
      if (currentDate == null || !isSameDay(currentDate!, transactionDate)) {
        // Display date separator
        transactionWidgets.add(
          Material(
            color: Colors.white,
            elevation: 2,
            child: Container(

              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Center(
                  child: Text(
                    _formatTimestamp(transactionDate),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        );
        currentDate = transactionDate;
      }

      // Display transaction data
      transactionWidgets.add(_buildTransactionItem(data));
    }

    return transactionWidgets;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatTimestamp(DateTime dateTime) {
    final String formattedDate =
    DateFormat('E, d MMM yyyy', 'en_US').format(dateTime);
    return formattedDate;
  }

  Widget _buildTransactionItem(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Money Transferred to',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                data['isCharity']
                    ? '${data['charityName'] ?? 'N/A'}'
                    : '${data['receiverTitle'].toString().toUpperCase()} - ${data['bankName'].toString().toUpperCase()}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            'Rs. ${double.parse(data['transactionAmount']).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              color: data['isCharity']
                  ? Colors.red
                  : (Common.loggedInAccountNo == data['receiverAccountNumber']
                  ? Colors.blue
                  : Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
