import 'dart:io';

import 'package:flutter/material.dart';


class ReplyFileCard extends StatelessWidget{
  const ReplyFileCard(
      {Key? key, required this.path, required this.message, required this.time})
      : super(key: key);
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[400],),
          child: Card(
            color: Color(0xffdcf8c6),
            margin: EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    "http://192.168.1.5:5000/uploads/$path",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                message.length >0 ?
                    Container(
                      height: 40,
                      padding: const EdgeInsets.only(
                          left: 15,top: 8),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}