// ignore_for_file: non_constant_identifier_names, unused_element, unnecessary_new

import 'package:flutter/material.dart';
import 'package:whatsapp/CustomUI/CustomCard.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/SelectContacts.dart';

class ChatsScreen extends StatefulWidget {

  const ChatsScreen({Key ? key , required this.users , required this.sourChat}) : super(key: key);
  final List<ChatModel> users;
  final ChatModel sourChat;

  @override
  _ChatsScreenState createState() => new _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<ChatModel> dummyData = [
    ChatModel(
      name: "Tanish Goyal",
      message: "Hey!",
      isGroup: false,
      time: "08:34 AM",
      id: 1,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "Pritpal Singh",
      message: "Hello!",
      isGroup: false,
      time: "04:34 AM",
      id: 2,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "Anshul",
      message: "kuch bhi!",
      isGroup: false,
      time: "09:14 AM",
      id: 3,
      avatarUrl:
          "https://www.iwmbuzz.com/wp-content/uploads/2020/03/jethalals-different-funny-faces-from-taarak-mehta-ka-ooltah-chashmah-1024x745.jpg",
    ),
    ChatModel(
      name: "Mayank",
      message: "Hiii!",
      isGroup: false,
      time: "11:45 PM",
      id: 4,
      avatarUrl:
          "https://static.punjabkesari.in/multimedia/15_25_1245260003434-ll.jpg",
    ),
    ChatModel(
      name: "Pankaj Kushwaha",
      message: "Hello Bhaiyaa!",
      isGroup: false,
      time: "07:45 AM",
      id: 5,
      avatarUrl:
          "https://i.pinimg.com/564x/bd/b8/75/bdb875dd9b807d03b19b21324a45cca0.jpg",
    ),
    new ChatModel(
      name: "Ananya",
      message: "Helooooooo!!",
      isGroup: false,
      time: "12:00 AM",
      id: 6,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "Aabash",
      message: "Your Welcome!",
      isGroup: false,
      time: "06:23 PM",
      id: 7,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "Harsh",
      message: "Wallah!!",
      isGroup: false,
      time: "08:34 PM",
      id: 8,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "Sarojini",
      message: "Hmmm hmmmmmm!",
      isGroup: true,
      time: "05:55 PM",
      id: 9,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "A4 Exclusive",
      message: "Class jaa rahe ho?!",
      isGroup: true,
      time: "12:45 AM",
      id: 10,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
    ChatModel(
      name: "F.A.R.E.N.D.S",
      message: "Cool Cool!",
      isGroup: true,
      time: "03:54 PM",
      id: 11,
      avatarUrl:
          "https://www.prameyanews.com/wp-content/uploads/2022/05/znuosa-K_400x400.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    isScrollable:
    true;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          child: new Icon(Icons.message_rounded),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => SelectContact()));
          },
        ),
        body: new ListView.builder(
            itemCount: widget.users.length,
            itemBuilder: (context, index) =>
                CustomCard(
                  chatModel: widget.users[index],
                  sourChat: widget.sourChat,
                  )));
  }
}
