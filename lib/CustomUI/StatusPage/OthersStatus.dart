
import 'dart:math';

import 'package:flutter/material.dart';


class OthersStatus extends StatelessWidget{

  const OthersStatus({Key? key , required this.imageName ,required this.name , required this.time, required this.isSeen, required this.statusNum }) : super(key: key);
  final String name;
  final String time;
  final String imageName;
  final bool isSeen;
  final int statusNum;

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: isSeen , statusNum: statusNum),
        child: CircleAvatar(
          radius: 26, 
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(imageName),
        ),
      ),
      title: Text(
        name,
        style : TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

degreeToAngle(double degree)
{
  return degree * pi/100;
}

class StatusPainter extends CustomPainter
{
  bool isSeen;
  int statusNum;
  StatusPainter({required this.isSeen , required this.statusNum});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen ? Colors.grey :Color(0XFF21BFA6)
      ..style = PaintingStyle.stroke;
      drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas , Size size , Paint paint)
  {
    if(statusNum==1)
    {
      canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngle(0) , 
        degreeToAngle(360), 
        false, 
        paint
      );
    }
    else
    {
      double degree = -90;
      double arc = 360 / statusNum;
      for(int i=0 ; i<statusNum ; i++)
      {
        canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        degreeToAngle(degree + 4) , 
        degreeToAngle(arc - 8), 
        false, 
        paint);
        degree  += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}