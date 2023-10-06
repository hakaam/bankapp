import 'package:bankapp/Home/fromaccounttoaccountscreeen.dart';
import 'package:flutter/material.dart';

class FromToTransferPayDetailsScreen extends StatefulWidget {
  @override
  State<FromToTransferPayDetailsScreen> createState() =>
      _FromToTransferPayDetailsScreenState();
}

class _FromToTransferPayDetailsScreenState
    extends State<FromToTransferPayDetailsScreen> {
  // Define a function to handle the click action

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
                            'https://ebanking.meezanbank.com/AmbitRetailFrontEnd/images/new-login-logo.png',
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
                                'Wasif Ibrahim',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '00234456742457 - College Road Lahore',
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
                                DetailsRow(
                                  leftText: 'Account Title',
                                  rightText: 'Muhammad Nadeem',
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
                                DetailsRow(
                                  leftText: 'Bank Name',
                                  rightText: 'Meezan Bank',
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
                                DetailsRow(
                                  leftText: 'Nick',
                                  rightText: 'Hamza Yaseen',
                                ),
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
                                DetailsRow(
                                  leftText: 'Amount',
                                  rightText: 'Rs.50',
                                  rightTextColor: Colors
                                      .white, // Set the color for the right text
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
                                DetailsRow(
                                  leftText: 'Bank Charges',
                                  rightText: 'Rs.0.00',
                                  rightTextColor: Colors
                                      .redAccent, // Set the color for the right text
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
                                DetailsRow(
                                  leftText: 'Total Amount',
                                  rightText: 'Rs.50.00',
                                  rightTextColor: Colors
                                      .white, // Set the color for the right text
                                ),
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
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Pay Successfully'),
                                backgroundColor: Colors.white,
                              ),
                            );
                          },
                          child: Text(
                            'Pay Now',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
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

class DetailsRow extends StatelessWidget {
  final String leftText;
  final String rightText;
  final Color leftTextColor; // Color for the left text
  final Color rightTextColor; // Color for the right text

  const DetailsRow({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.leftTextColor = Colors.white, // Default color is white
    this.rightTextColor = Colors.white, // Default color is white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: TextStyle(
            color: leftTextColor, // Use the specified color for the left text
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          rightText,
          style: TextStyle(
            color: rightTextColor, // Use the specified color for the right text
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
