import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/Auth/signin.dart';
import '../Providers/Authprovider/auth_provider.dart';
import '../utils/common.dart';
import 'fromtotransferpaycharitiesdetails.dart';
import '../Accounts/fromtotransferpaydetails.dart';

class FromAccountToAccountCharityScreen extends StatefulWidget {
  final String charityImgUrl;
  final String charityName;

  const FromAccountToAccountCharityScreen({
    Key? key,
    required this.charityImgUrl,
    required this.charityName,
  });

  @override
  State<FromAccountToAccountCharityScreen> createState() =>
      _FromAccountToAccountCharityScreenState();
}

class _FromAccountToAccountCharityScreenState
    extends State<FromAccountToAccountCharityScreen> {
  AuthProvider authProvider = AuthProvider();

  String? selectedOption = 'Others';
  List<String> options = [
    'Card Bill Payment',
    'Donation Or Charity',
    'Rental Payment',
    'Hotel Payment',
    'School and University Fee Payment',
    'Supplier and Distributor Payment'
  ];
  TextEditingController amountController = TextEditingController();

  String selectedCurrency = Common.currency;
  double userBalance = Common.userBalances[Common.currency]?.toDouble();
  String userName = ''; // To store the user's name
  String accountNumber = ''; // To store the user's account number

  @override
  void initState() {
    super.initState();
    selectedOption = 'Others';
    fetchCurrentUserDetails();
  }

  void fetchCurrentUserDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;

        final userData =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userData.exists) {
          setState(() {
            userName = userData['name'];
            accountNumber = userData['accountNumber'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                return ListTile(
                  title: Center(child: Text(option)),
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 58,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade600,
          ),
          onPressed: () {
            Future<void> handleNextButtonPressed() async {
              String amountText = amountController.text;
              if (amountText.isNotEmpty) {
                double amount = double.tryParse(amountText) ?? 0.0;

                if (amount > 0 && amount <= userBalance) {
                  // Calculate the total transferred amount
                  double totalTransferredAmount = amount;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FromToTransferPayDetailsCharitiesScreen(
                        fromAccountUserName: userName,
                        // accountTitle: widget.accountTitle,
                        charityName: widget.charityName,
                        charityImgUrl: widget.charityImgUrl,
                        accountNumber: accountNumber,
                        // nickName: widget.nickName,
                        amount: amount.toStringAsFixed(2),
                        userBalance: userBalance,
                        // receiverAccountNumber: widget.receiverAccountNumber,
                      ),
                    ),
                  );
                } else {
                  // Handle insufficient balance
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Insufficient Balance'),
                          content: Text(
                              'Your balance is not sufficient for this transaction.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              }
            }

            handleNextButtonPressed();
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
      ),
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()),
                                  (Route<dynamic> route) => false);
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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
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
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                  fontSize: 19,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    accountNumber,
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'To Account',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              widget.charityImgUrl,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              widget.charityName,
                              style: TextStyle(
                                color: Colors.blue.shade600,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 47,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: amountController,
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        helperText:
                            "Enter an amount between Rs.1 and\n Rs.1,000,000.",
                        helperStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
}
