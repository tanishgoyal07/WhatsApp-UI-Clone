import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:whatsapp/NewScreen/LoginPage.dart';
import 'package:whatsapp/pages/LoginScreen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {Key? key, required this.phnNumber, required this.countryCode})
      : super(key: key);
  final String phnNumber;
  final String countryCode;
  @override
  _OTPScreenState createState() => new _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    var pin = 123456;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verify ${widget.countryCode} ${widget.phnNumber}",
          style: TextStyle(
            color: Colors.teal[800],
            fontSize: 16.5,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              )),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(children: [
              TextSpan(
                text: "We have sent an SMS with a code to ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                ),
              ),
              TextSpan(
                text :widget.countryCode + " " + widget.phnNumber,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " Wrong number?",
                style: TextStyle(
                  color: Colors.cyan[800],
                  fontSize: 14.5,
                ),
              ),
            ])),
            SizedBox(
              height: 5,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (String str) {

              },
              onCompleted: (pin) {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (builder) => LoginScreen()));
                print("Completed" + pin);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Enter 6-digit code",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.5,
                ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: Colors.teal,
                  size: 24,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Resend SMS",
                  style: TextStyle(
                  color: Colors.teal,
                  fontSize: 14.5,
                ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1.5,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: Colors.teal,
                  size: 24,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  "Call Me",
                  style: TextStyle(
                  color: Colors.teal,
                  fontSize: 14.5,
                ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
