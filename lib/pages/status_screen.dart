import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:whatsapp/CustomUI/StatusPage/OthersStatus.dart';

class StatusScreen extends StatefulWidget {
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 48,
              child: FloatingActionButton(
                backgroundColor: Colors.blueGrey[100],
                onPressed: () {},
                child: Icon(Icons.edit, color: Colors.blueGrey[900]),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
              height: 48,
              child: FloatingActionButton(
                backgroundColor: Color(0xff075E54),
                onPressed: () {},
                elevation: 5,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            HeadOwnStatus(),
            label("Recent updates"),            
            const OthersStatus(
              name: "Tanish Goyal",
              time: "29 minutes ago",
              imageName: "assets/tg.jpg",
              isSeen: false,
              statusNum: 6,
            ),
            const OthersStatus(
              name: "Pritpal Singh",
              time: "Today, 6:19 AM",
              imageName: "assets/pritpal.jpg",
              isSeen: false,
              statusNum: 3,
            ),
            const OthersStatus( 
              name: "Mohan",
              time: "Today, 9:19 PM",
              imageName: "assets/pankaj.jpg",
              isSeen: false,
              statusNum: 10,
            ),
            const OthersStatus( 
              name: "Aabash",
              time: "Today, 4:54 PM",
              imageName: "assets/aabash.jpg",
              isSeen: false,
              statusNum: 2,
            ),
            const SizedBox(
              height : 10,
            ),
            label("Viewed updates"),
            
            const OthersStatus( 
              name: "Anshul",
              time: "Today, 9:19 PM",
              imageName: "assets/ab.jpg",
              isSeen: true,
              statusNum: 15,
            ),
            const OthersStatus(
              name: "Mayank",
              time: "Today, 9:19 PM",
              imageName: "assets/qwerty.jpg",
              isSeen: true,
              statusNum: 6,
            ),
            const OthersStatus(
              name: "Ananya",
              time: "Today, 3:16 PM",
              imageName: "assets/ananya.jpg",
              isSeen: true,
              statusNum: 3,
            ),
            const OthersStatus(
              name: "Pankaj Kushwaha",
              time: "Today, 9:19 PM",
              imageName: "assets/mohan.jpg",
              isSeen: true,
              statusNum: 2,
            ),
            const OthersStatus(
              name: "Harsh",
              time: "Today, 9:34 PM",
              imageName: "assets/hg.jpg",
              isSeen: true,
              statusNum: 2,
            ),
          ],
        )));
  }

  Widget label(String labelname) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        child: Text(
          labelname,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
