import 'package:flutter/material.dart';

class FromAccountToAccountScreen extends StatefulWidget {
  @override
  State<FromAccountToAccountScreen> createState() =>
      _FromAccountToAccountScreenState();
}

class _FromAccountToAccountScreenState
    extends State<FromAccountToAccountScreen> {
  String? selectedOption = 'Others'; // Initialize selectedOption with 'Others'

  List<String> options = [
    'Card Bill Payment',
    'Donation Or Charity',
    'Rental Payment',
    'Hotel Payment',
    'School and University Fee Payment',
    'Supplier and Distributor Payment'
  ];

  // Your list of options
  @override
  void initState() {
    super.initState();
    selectedOption = 'Others'; // Set 'Others' as the default value
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
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
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
                                'Usman',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 19),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '00022236543289',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    '-',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'College...',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19),
                                  )
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
                          Image.asset(
                            'images/silkk.PNG',
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Usman',
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
                    Text(
                      'Available balance RS.199',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    TextField(
                      style: TextStyle(color: Colors.white), // Text color
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
                            color: Colors
                                .white, // Change this color to your desired underline color
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors
                                .white, // Change this color to your desired underline color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Purpose of Paymentttt',
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
                        alignment: Alignment
                            .center, // Center the DropdownButtonFormField
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropdownButtonFormField<String>(
                              isExpanded:
                                  true, // Make the dropdown list expand to fit content

                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .white, // Change this color to your desired underline color
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors
                                        .white, // Change this color to your desired underline color
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors
                                      .transparent, // Make the hint text transparent
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors
                                      .white), // Text color for selected option
                              value: selectedOption,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Others', // Unique value for the hint
                                  child: Center(
                                    // Center-align the hint "Others"
                                    child: Text(
                                      'Others',
                                      style: TextStyle(
                                        color: Colors
                                            .black, // Text color for "Others" option
                                      ),
                                    ),
                                  ),
                                ),
                                ...options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Center(
                                      // Center-align the dropdown options
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Text color for dropdown options
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
                              selectedOption ??
                                  'Others', // Show selected option or "Others" if no option is selected
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddBeneficiaryDetailsScreen(),
                    //   ),
                    // );
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
}
