import 'package:bankapp/Home/currency_converter.dart';
import 'package:bankapp/Home/transfer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
            CurrencyConverter(),

            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TransferScreen()));
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


// Define CharitiesScreen similarly to StatementScreen
