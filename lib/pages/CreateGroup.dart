import "package:flutter/material.dart";
import 'package:whatsapp/CustomUI/AvatarCard.dart';
import 'package:whatsapp/CustomUI/ContactCard.dart';
import 'package:whatsapp/models/chat_model.dart';

class CreateGroup extends StatefulWidget {
  //CreateGroup({required Key  key}) : super(key: key);

  @override
  _CreateGroupState createState() => new _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ContactModel> contacts = [
    ContactModel(
      name: "Tanish Goyal",
      status: "Helooo",
    ),
    ContactModel(
      name: "Mayank Airan",
      status: "Namaste",
    ),
    ContactModel(
      name: "Pritpal Singh",
      status: "Wowwww",
    ),
    ContactModel(
      name: "Anshul",
      status: "But the thing is!!!",
    ),
    ContactModel(
      name: "Pankaj Kushwaha",
      status: "Bahut Marunga",
    ),
    ContactModel(
      name: "Ananya",
      status: "heloooo",
    ),
    ContactModel(
      name: "Harsh Pareek",
      status: "Desert Safari",
    ),
    ContactModel(
      name: "Harsh Gupta",
      status: "Sir jiiii",
    ),
    ContactModel(
      name: "Aabash Saxena",
      status: "Aur bata!!!",
    ),
    ContactModel(
      name: "Prince",
      status: "Thik hai bhai!!!",
    ),
  ];

  List<ContactModel> groupmember = [];

  @override
  Widget build(BuildContext context) {
    isScrollable:
    true;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          child: new Icon(Icons.arrow_forward_rounded),
          onPressed: () {},
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff075E54),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Group",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length+1,
                itemBuilder: (context, index) {
                  if(index==0)
                  {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index-1].select == true) {
                          groupmember.remove(contacts[index-1]);
                          contacts[index-1].select = false;
                        } else {
                          groupmember.add(contacts[index-1]);
                          contacts[index-1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      contact: contacts[index-1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Align(
                  child: Column(
                      children: [
                        Container(
                          height: 75,
                          color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                if (contacts[index].select = true)
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        groupmember.remove(contacts[index]);
                                        contacts[index].select = false;
                                      });
                                    },
                                    child: AvatarCard(
                                      contactModel: contacts[index],
                                    ),
                                  );
                                return Container();
                              }),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                    alignment: Alignment.topCenter,
                )
                : Container(),
          ],
        ));
  }
}
