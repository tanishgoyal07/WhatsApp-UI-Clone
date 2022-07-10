import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:whatsapp/CustomUI/StatusPage/OthersStatus.dart';

class CallsScreen extends StatefulWidget {
  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 48,
              child: FloatingActionButton(
                backgroundColor: Color(0xff075E54),
                onPressed: () {},
                elevation: 5,
                child: Icon(
                  Icons.add_call,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children:[
            CallCard(
              "Tanish Goyal",
              "29 minutes ago",
              "assets/tg.jpg",
              Icons.call_made_rounded,
            ),
            CallCard(
              "Pritpal Singh",
              "Today, 6:19 PM",
              "assets/prito.jpg",
              Icons.call_missed,
            ),
            CallCard(
              "Anshul",
              "Today, 9:19 PM",
              "assets/anshul.jpg",
              Icons.call_received,
            ),
            CallCard(
              "Mayank",
              "Today, 9:19 PM",
              "assets/qwerty.jpg",
              Icons.call_received,
            ),
            CallCard(
              "Pankaj Kushwaha",
              "Today, 9:19 PM",
              "assets/mohan.jpg",
              Icons.call_made_rounded,
            ),
            CallCard(
              "Aabash Saxena",
              "July 5, 3:19 PM",
              "assets/aabash.jpg",
              Icons.call_missed,
            ),
            CallCard(
              "Ananya",
              "July 3, 12:40 PM",
              "assets/ananya.jpg",
              Icons.call_made_rounded,
            ),
            CallCard(
              "Harsh",
              "July 1, 10:16 AM",
              "assets/harsh.jpg",
              Icons.call_received,
            ),
            CallCard(
              "Mohan",
              "July 1, 10:08 AM",
              "assets/pankaj.jpg",
              Icons.call_made_rounded,
            ),
          ],
        )
    );
  }
  
  Widget CallCard(String name , String time , String imageName , IconData iconData )
  {
    return Card(
      margin: EdgeInsets.only(bottom: 0.5),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imageName),
            ),
          ],
        ),
        title: Text(
          name,
          style : TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )
        ),
        subtitle: Row(
          children: [
            Icon(
              iconData,
              color: Colors.green,
              size:28,
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[900],
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.call,
          size: 28,
          color : Color(0xff075E54),
        ),
      ),
    );
  }
}
