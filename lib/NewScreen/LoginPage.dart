import 'package:flutter/material.dart';
import 'package:whatsapp/NewScreen/CountryPage.dart';
import 'package:whatsapp/NewScreen/OTPScreen.dart';
import 'package:whatsapp/models/CountryModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "India";
  String countryCode = "+91";
  TextEditingController _controller = TextEditingController();

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
            color: Color(0xff075E54),
            fontWeight: FontWeight.w700,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        actions: [
          Icon(Icons.more_vert, color: Colors.black),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "WhatsApp will send an sms message to verify your number",
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "What's my number",
              style: TextStyle(
                fontSize: 12.8,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CountryCard(),
            SizedBox(
              height: 5,
            ),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if(_controller.text.length < 10)
                {
                  noTextDialogue();
                }
                else{
                  showMyDialogue();
                }
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.tealAccent[400],
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget CountryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    CountryPage(setcountryData: setCountryData)
            )
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.teal,
          width: 1.8,
        ))),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryName,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            ))),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  "+",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.teal,
                width: 1.8,
              ))),
              width: MediaQuery.of(context).size.width / 1.5 - 100,
              child: TextFormField(
                controller : _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                  hintText: "Phone number",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialogue()
  {
    return showDialog(
      context: context,
      builder: (BuildContext context){
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We will be verifying your phone number",
                style: TextStyle(
                      fontSize: 14,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                countryCode + " " + _controller.text,
                style: TextStyle(
                      fontSize: 14,
                    ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Is this Ok, or would you like to edit the number",
                style: TextStyle(
                      fontSize: 13.5,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Edit",
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (builder) => OTPScreen(phnNumber: _controller.text, countryCode: countryCode,),
              ));
            },
            child: Text(
              "Ok",
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
        ],
      );
    });
  }

  Future<void> noTextDialogue()
  {
    return showDialog(
      context: context,
      builder: (BuildContext context){
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "There is no valid number entered",
                style: TextStyle(
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Try Again",
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
        ],
      );
    });
  }
}
