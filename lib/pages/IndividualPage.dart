// import 'dart:html';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/CustomUI/OwnFileCard.dart';
import 'package:whatsapp/CustomUI/OwnMessageCard.dart';
import 'package:whatsapp/CustomUI/ReplyCard.dart';
import 'package:whatsapp/CustomUI/ReplyFileCard.dart';
import 'package:whatsapp/models/MessageModel.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/CameraView.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  IndividualPage({Key? key, required this.chatModel, required this.sourChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourChat;

  @override
  _IndividualPageState createState() => new _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  ScrollController _scrollController = ScrollController();
  TextEditingController _controller = TextEditingController();
  late IO.Socket socket;
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.5:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("/signin", widget.sourChat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage(
          "destination",
          msg["message"],
          msg["path"],
        );
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId ,String path) {
    setMessage("source", message , path);
    socket.emit("message", {
      "message": message,
      "sourceid": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage(String type, String message , String path) {
    MessageModel messageModel = MessageModel(
        message : message,
        type : type,
        path : path,
        time : DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  void onImageSend(String path , String message) async
  {
    for(int i=0 ; i<popTime ; i++)
    {
      Navigator.pop(context);
    }
    setState(() { 
      popTime = 0;
    });
    var request = http.MultipartRequest(
      "POST" , Uri.parse("http://192.168.1.5:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    setMessage("source", message , path);

    socket.emit("message", {
      "message": message,
      "sourceid": widget.sourChat.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xff075E54),
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Theme.of(context).secondaryHeaderColor,
                  radius: 20, //for svg icon
                  child: SvgPicture.asset(
                    widget.chatModel.isGroup
                        ? "assets/groups.svg"
                        : "assets/person.svg",
                    color: Colors.white,
                    height: 35,
                    width: 35,
                  ),
                )
              ]),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "last seen today at 01:20",
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.videocam_rounded), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute notifications"),
                      value: "Mute notifications",
                    ),
                    PopupMenuItem(
                      child: Text("Dissapearing messages"),
                      value: "Dissapearing messages",
                    ),
                    PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                    PopupMenuItem(
                      child: Text("More"),
                      value: "More",
                    ),
                  ];
                },
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source")
                        {
                          if(messages[index].path.length >0)
                          {
                            return OwnFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                          else{
                              return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                        else
                        {
                          if(messages[index].path.length >0)
                          {
                            return ReplyFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                          else
                          {
                            return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 70,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: TextFormField(
                                      controller: _controller,
                                      focusNode: focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.length > 0) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          sendButton = false;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Message",
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.emoji_emotions_outlined,
                                          ),
                                          onPressed: () {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              show = !show;
                                            });
                                          },
                                        ),
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                    Icons.attach_file_rounded),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomSheet());
                                                }),
                                            IconButton(
                                                icon:
                                                    Icon(Icons.currency_rupee),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(
                                                    Icons.camera_alt_rounded),
                                                onPressed: () {
                                                  setState(() {
                                                    popTime = 2;
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              CameraScreen(
                                                                onImageSend: onImageSend,
                                                              )));
                                                }),
                                          ],
                                        ),
                                        contentPadding: EdgeInsets.all(5),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                  right: 5.0,
                                  left: 2.0,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff075E54),
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      sendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                        sendMessage(
                                            _controller.text,
                                            widget.sourChat.id,
                                            widget.chatModel.id,
                                            "",
                                        );
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 370,
      width: MediaQuery.of(context).size.width,
      child: Card(
          margin: EdgeInsets.all(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(Icons.insert_drive_file_rounded,
                        Color.fromARGB(255, 133, 43, 185), "Document"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.camera_alt_rounded,
                        Color.fromARGB(255, 213, 48, 81), "Camera"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(
                      Icons.photo_size_select_actual_rounded,
                        Color.fromARGB(255, 170, 55, 187), "Gallery" ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(Icons.headphones_rounded,
                        Color.fromARGB(255, 215, 102, 42), "Audio"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.currency_rupee_rounded,
                        Color.fromARGB(255, 26, 103, 94), "Payment"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.location_pin, Colors.green, "Location"),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconCreation(Icons.person, Colors.blueAccent, "Contact"),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.bluetooth_audio, Colors.transparent, ""),
                    SizedBox(
                      width: 40,
                    ),
                    iconCreation(Icons.bluetooth_audio, Colors.transparent, ""),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () async {
        if (text == "Camera")
        {
          setState(() {
            popTime = 3;
          });
          Navigator.push(
              context, MaterialPageRoute(
                builder: (builder) => CameraScreen(
                  onImageSend: onImageSend,
                )));
        }
        else if (text == "Gallery")
        {
          setState(() {
            popTime = 2;
          });
          file = await _picker.pickImage(source: ImageSource.gallery);
          Navigator.push(
              context, MaterialPageRoute(
                builder: (builder) => CameraView(
                  path:file!.path,
                  onImageSend: onImageSend,
              ),
          ));
        }
        print(text);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      onEmojiSelected: (emoji, category) {
        rows:
        4;
        columns:
        7;
        print(emoji);
        setState(() {
          // _controller.text = _controller.text + emoji.emoji;
        });
      },
    );
  }
}
