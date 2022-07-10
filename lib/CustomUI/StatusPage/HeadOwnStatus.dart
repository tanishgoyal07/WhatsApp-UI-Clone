import 'package:flutter/material.dart';


class HeadOwnStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/myrd.jpeg"),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Color(0xff075E54),
              radius : 10,
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      title: Text(
        "My status",
        style : TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )
      ),
      subtitle: Text(
        "Tap to add status update",
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}