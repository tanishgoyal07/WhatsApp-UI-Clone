import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/CameraPage.dart';
import 'package:whatsapp/pages/CreateGroup.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/chat_screen.dart';
import 'package:whatsapp/pages/status_screen.dart';
import 'package:whatsapp/pages/call_screen.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({Key ? key , required this.users , required this.sourChat}) : super(key: key);
  final List<ChatModel> users;
  final ChatModel sourChat;


  @override
  _WhatsAppHomeState createState() => new _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double yourWidth = width / 5;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff075E54),
        title: Text("WhatsApp"),
        elevation: 0.7,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              if(value == "New group")
              {
                Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => CreateGroup()));
              }
              else{
                print(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Linked devices"),
                  value: "Linked devices",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Payments"),
                  value: "Payments",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        bottom: TabBar(
          // isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Container(
              width: 15,
              alignment: Alignment.center,
              child: Tab(
                  icon: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              )),
            ),
            Container(
              width: yourWidth,
              alignment: Alignment.center,
              child: Tab(text: "CHATS"),
            ),
            Container(
              width: yourWidth,
              alignment: Alignment.center,
              child: Tab(text: "STATUS"),
            ),
            Container(
              width: yourWidth,
              alignment: Alignment.center,
              child: Tab(text: "CALLS"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CameraPage(),
          ChatsScreen(
            users: widget.users,
            sourChat: widget.sourChat,
          ),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
    );
  }
}
