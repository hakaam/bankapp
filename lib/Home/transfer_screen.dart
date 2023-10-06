import 'package:bankapp/Home/bank_screen.dart';
import 'package:bankapp/Home/fromaccounttoaccountscreeen.dart';
import 'package:flutter/material.dart';
class TransferScreen extends StatefulWidget {
  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
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
                      IconButton(onPressed: (){
                        Navigator.pop(context);

                      }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                      Text('Send Money',style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white


                      ),)

                    ],


                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home_outlined,color: Colors.orange,),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications,color: Colors.orange),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.power_settings_new,color: Colors.orange),
                      ),

                    ],

                  )


                ],


              ),



            ),

            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search(e.g.nick,account,title,bank)',
                    hintStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 8), // Adjust the padding as needed
                      child: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: Image.asset('images/profile.PNG'),
                            // Your existing code for the image
                            // ...
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>BankScreen()));


                              },
                              child: Text('Add New Beneficiary',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold

                                ),

                              ),
                            ),
                            // Your existing code for "Add New Beneficiary"
                            // ...
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 10,),

                  BeneficiaryItem(
                    bankName: 'Alfalah',
                    accountNumber: 'Bank Alfalah-0002345894358723',
                    imagePath: 'images/bankalfla.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),

                  BeneficiaryItem(
                    bankName: 'Hamza',
                    accountNumber: 'Bank Al-Habib-0002345894358723',
                    imagePath: 'images/alhabib.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),

                  BeneficiaryItem(
                    bankName: 'Zain',
                    accountNumber: 'Summit Bank-0002345894358723',
                    imagePath: 'images/smmit.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),

                  BeneficiaryItem(
                    bankName: 'Farhat',
                    accountNumber: 'Meezan Bank-0002345894358723',
                    imagePath: 'images/mezan.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),
                  BeneficiaryItem(
                    bankName: 'Washu',
                    accountNumber: 'Silk Bank-0002345894358723',
                    imagePath: 'images/silk.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),

                  BeneficiaryItem(
                    bankName: 'Taha',
                    accountNumber: 'HBL KONNECT -0002345894358723',
                    imagePath: 'images/hbl.PNG', // Replace with your image path
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  ),
                  SizedBox(height: 8,),
                  // Add more Row widgets or other widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BeneficiaryItem extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String imagePath;

  const BeneficiaryItem({
    Key? key,
    required this.bankName,
    required this.accountNumber,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FromAccountToAccountScreen()));


            },
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Image.asset(
                  imagePath,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Flexible(
              flex: 6,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          bankName,
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete, color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      accountNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Your existing code for "Add New Beneficiary"
                // ...
              ),
            ),
          ],
        ),
      ),
    );
  }
}