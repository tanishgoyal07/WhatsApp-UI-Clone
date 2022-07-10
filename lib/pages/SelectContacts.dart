import "package:flutter/material.dart";
import 'package:whatsapp/CustomUI/ButtonCard.dart';
import 'package:whatsapp/CustomUI/ContactCard.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  // SelectContact({required Key  key}) : super(key: key);

  @override
  _SelectContactState createState() => new _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {

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

    isScrollable: true;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff075E54),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Contact",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "246 Contacts",
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
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: contacts.length+2,
          itemBuilder: (context, index)
          {
            if(index==0)
            {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context , MaterialPageRoute(builder: (builder)=> CreateGroup()
                    )
                  );
                },
                child: ButtonCard(
                  icon: Icons.people,
                  name : "New group"
                ),
              );
            }
            else if(index==1)
            {
              return ButtonCard(
                icon: Icons.person_add,
                name: "New contact",
              );
            }
            else
            {
              return ContactCard(
                contact: contacts[index-2],
              );
            }
          }
        )
      );
  }
}
