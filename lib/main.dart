
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/NewScreen/LandingScreen.dart';
import 'package:whatsapp/pages/LoginScreen.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/whatsapp_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  
  runApp(MyApp());
}
  

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  { 
    return MaterialApp(
      title: "Whatsapp",
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.green,
        // secondaryHeaderColor: Color(0xff25D366),
        secondaryHeaderColor: Color(0xff075E54),
      ),
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}