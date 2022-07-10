import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/models/chat_model.dart';


class ButtonCard extends StatelessWidget{
  const ButtonCard({Key? key , required this.name ,required this.icon}) : super(key : key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xff075E54),
        radius: 23,
        child: Icon(
          icon,
          color: Colors.white,
        ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
    );
  }
}