import 'package:bankapp/Home/currency_converter.dart';
import 'package:bankapp/Home/transfer_screen.dart';
import 'package:bankapp/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'PKR';

  String userName = '';
  Map<String, dynamic> userBalances = {};

  void updateUserBalance(double newBalance) {
    setState(() {
      Common.balance = newBalance.toInt();
      userBalances[selectedCurrency] = newBalance;
    });
  }

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

            setState(() {
              userBalances = balances;
            });

        }
      }
    } catch (e) {
      print("Error fetching user balance: $e");
    }
  }

  Future<void> fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'];
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchUserBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxISUh29JCh76Q0sJeVWYmHRN0Nb2dHLcL1Il-d0-PYvF7aYmrncNJU3FazosIpe4eR5w&usqp=CAU',
                scale: 2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${userBalances[selectedCurrency]?.toStringAsFixed(2) ?? "0.00"} $selectedCurrency',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              DropdownButton<String>(
                                value: selectedCurrency,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCurrency = newValue!;
                                    Common.currency = selectedCurrency;
                                    Common.balance =
                                        userBalances[selectedCurrency];
                                  });
                                },
                                items: ['PKR', 'USD', 'CAD']
                                    .map((String currency) {
                                  return DropdownMenuItem<String>(
                                    value: currency,
                                    child: Text(currency),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '$userName',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferScreen(),
                    ),
                  );
                },
                child: Text('Transfer'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to handle the "Statement" button click
                },
                child: Text('Statement'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to handle the "Charities" button click
                },
                child: Text('Charities'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
