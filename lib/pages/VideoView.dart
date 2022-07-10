import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videoview extends StatefulWidget {
  Videoview({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  State<Videoview> createState() => _VideoviewState();
}

class _VideoviewState extends State<Videoview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, actions: [
        IconButton(
          icon: Icon(
            Icons.crop_rotate,
            size: 22,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.emoji_emotions_outlined,
            size: 22,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.title,
            size: 22,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            size: 22,
          ),
          onPressed: () {},
        ),
      ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ), 
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27,
                    ),
                    hintText: "Add a caption...",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    suffixIcon: CircleAvatar(
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      radius: 27,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying? Icons.pause : Icons.play_arrow,
                    color: Colors.white ,  size: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
