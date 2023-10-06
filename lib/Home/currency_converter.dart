import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addbeneficiarydetailscreen.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String selectedCurrency = 'PKR';
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();

  String userName = '';
  double userBalance = 0.0;
  double convertedBalance = 0.0; // Store the converted balance

  final Map<String, double> conversionRates = {
    'PKR': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
    'CAD': 1.25,
    'AUD': 1.3,
  };

  Future<void> fetchUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection("users").doc(userId).get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          userBalance = userDoc['balance'].toDouble();
          // Update the converted balance whenever userBalance or selectedCurrency changes
          convertedBalance = userBalance / conversionRates[selectedCurrency]!;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
          
        

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display the converted balance

                Text(
                  '${convertedBalance.toStringAsFixed(2)} $selectedCurrency',
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
                            // Update the converted balance when currency changes
                            convertedBalance = userBalance / conversionRates[selectedCurrency]!;
                          });
                        },
                        items: conversionRates.keys.map((String currency) {
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

            Text('$userName',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
              ),
            ),



          ],
        ),
      ),
    );
  }
}
