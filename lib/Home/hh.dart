import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FromAccountToAccountScreen extends StatefulWidget {
  final String imagePath;
  final String accountTitle;

  const FromAccountToAccountScreen({
    Key? key,
    required this.imagePath,
    required this.accountTitle,
  });

  @override
  State<FromAccountToAccountScreen> createState() =>
      _FromAccountToAccountScreenState();
}

class _FromAccountToAccountScreenState
    extends State<FromAccountToAccountScreen> {
  String? selectedOption = 'Others';

  List<String> options = [
    'Card Bill Payment',
    'Donation Or Charity',
    'Rental Payment',
    'Hotel Payment',
    'School and University Fee Payment',
    'Supplier and Distributor Payment'
  ];

  String userName = ''; // To store the user's name
  String accountNumber = ''; // To store the user's account number
  double balance = 0.0; // To store the user's balance as a double
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedOption = 'Others';
    fetchUserDetails(); // Fetch user details when the screen is initialized
  }

  // Fetch user details based on the accountTitle
  void fetchUserDetails() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your users collection name
          .where('name', isEqualTo: widget.accountTitle)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final user = querySnapshot.docs.first;
        setState(() {
          userName = user['name'];
          accountNumber = user['accountNumber'];
          // Assuming you have a 'balance' field in your user document
          balance = (user['balance'] ?? 0.0).toDouble();
        });
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
                    Navigator.pop(context); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void deductAmountFromBalance(double amount) {
    setState(() {
      balance -= amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          onPressed: () {
                            // Add navigation logic here
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
                          onPressed: () {
                            // Add navigation logic here
                          },
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add notification logic here
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.orange,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Add power settings logic here
                          },
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Colors.orange,
                          ),
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
                        color: Colors.orange,
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
                                    color: Colors.black, fontSize: 19),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    accountNumber,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19),
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
                        color: Colors.orange,
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
                          Image.network(
                            widget.imagePath,
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.accountTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    TextField(
                      controller: amountController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        helperText:
                        "Enter an amount between Rs.1 and\n Rs.1,000,000.",
                        helperStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.orange,
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
                    Text(
                      'Purpose of Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showOptionsDialog(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
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
                                hintStyle: TextStyle(
                                  color: Colors.transparent,
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              value: selectedOption,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Others',
                                  child: Center(
                                    child: Text(
                                      'Others',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                ...options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Center(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedOption = newValue!;
                                });
                              },
                            ),
                            Text(
                              selectedOption ?? 'Others',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Container(
                height: 58,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    // Add your logic for the "Next" button here
                    String amountText = amountController.text;
                    if (amountText.isNotEmpty) {
                      double amount = double.parse(amountText);
                      if (amount > 0 && amount <= 1000000) {
                        // Deduct the entered amount from the balance
                        deductAmountFromBalance(amount);
                        // Now you can use 'amount' for further processing
                        // Update the balance in Firestore here
                        updateBalanceInFirestore(balance);
                      } else {
                        // Handle invalid amount
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Amount'),
                              content: Text(
                                  'Please enter an amount between Rs.1 and Rs.1,000,000.'),
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
                    }
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateBalanceInFirestore(double newBalance) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Update the balance in Firestore for the current user
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({'balance': newBalance});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    amountController.dispose();
    super.dispose();
  }

}


