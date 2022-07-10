import 'dart:math';

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/pages/CameraView.dart';
import 'package:whatsapp/pages/VideoView.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {

  const CameraScreen({Key ? key, required this.onImageSend}) : super(key : key);
  final Function onImageSend;

  @override
  _CameraScreenState createState() => new _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  Future<void>? cameravalue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameravalue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameravalue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController)
                  );
                } 
                 else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash? Icons.flash_on : Icons.flash_off,
                          color : flash? Colors.yellow : Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash ? _cameraController.setFlashMode(FlashMode.torch) : _cameraController.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();

                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async{
                          XFile videopath =  await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(context, MaterialPageRoute(
                            builder: (builder)=> Videoview(
                              path : videopath.path,
                            ))
                          );
                        },
                        onTap: () {
                          if(!isRecording){
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? Icon(Icons.radio_button_on,
                                color: Colors.grey, size: 48)
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: () async{
                          setState(() {
                             iscamerafront = !iscamerafront;
                             transform = transform + pi;
                           });
                          int cameraPos = iscamerafront? 0 : 1;
                          _cameraController = CameraController(
                            cameras[cameraPos], ResolutionPreset.high);
                           cameravalue = _cameraController.initialize();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile file = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraView(
                  path: file.path,
                  onImageSend: widget.onImageSend,
                )));
  }
}
