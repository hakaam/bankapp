import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String selectedCurrency = 'USD'; // Default selected currency
  TextEditingController nameController = TextEditingController(); // Controller for the name TextField
  TextEditingController balanceController = TextEditingController(); // Controller for the balance TextField

  // Fetched user data
  String userName = ''; // Store user's name
  double userBalance = 0.0; // Store user's balance

  // Define conversion rates for each currency
  final Map<String, double> conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
    'CAD': 1.25,
    'AUD': 1.3,
  };

  // Fetch user data from Firestore
  void fetchUserData() async {
    // Replace 'users' with your Firestore collection name
    final userDoc = await FirebaseFirestore.instance.collection('users').doc('user_id').get();

    if (userDoc.exists) {
      setState(() {

        userName = userDoc['name'];
        userBalance = userDoc['balance'];
        nameController.text = userName;
        balanceController.text = userBalance.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
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
        SizedBox(height: 15,),
        TextField(
          controller: nameController, // Set the controller for the name TextField
          decoration: InputDecoration(labelText: 'Name'), // Your other properties for this TextField
        ),
        TextField(
          controller: balanceController, // Set the controller for the balance TextField
          decoration: InputDecoration(labelText: 'Balance'), // Your other properties for this TextField
        ),
      ],
    );
  }
}
