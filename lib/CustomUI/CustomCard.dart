import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/IndividualPage.dart';


class CustomCard extends StatelessWidget{

  const CustomCard({Key? key, required this.chatModel , required this.sourChat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourChat;

  @override
  Widget build(BuildContext context){
    return InkWell(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => IndividualPage(
                  chatModel: chatModel,
                  sourChat: sourChat,
                )));
            },
             child: Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    foregroundColor: Theme.of(context).secondaryHeaderColor,
                    radius: 30,                     //for svg icon
                    child: SvgPicture.asset(
                      chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                      color: Colors.white,
                      height: 37,
                      width: 37,
                    
                    ),
                    // backgroundImage: new NetworkImage(chatModel.avatarUrl),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        chatModel.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        chatModel.time,
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.done_all , size: 18),
                      SizedBox(
                        width: 3,
                      ),
                      // padding: const EdgeInsets.only(top: 5.0),
                      Text(
                        chatModel.message,
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
     );
  }
}