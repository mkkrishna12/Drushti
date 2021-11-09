import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import '../Map/home.dart';
import 'bndbox.dart';
import 'camera.dart';

const String ssd = "SSD MobileNet";
const String yolo = "Tiny YOLOv2";

class HomePage extends StatefulWidget {
  static const String id = 'homepage';
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = ssd;
  loadModel() async {
    String res = await Tflite.loadModel(
      model: "assets/models/ssd_mobilenet.tflite",
      labels: "assets/models/ssd_mobilenet.txt",
      // numThreads: 1, // defaults to 1
      // isAsset:
      //     true, // defaults to true, set to false to load resources outside assets
      // useGpuDelegate:
      //     false // defaults to false, set to true to use GPU delegate
    );

    print(res);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _model = ssd;
    });
    loadModel();
  }

  onSelect() {
    setState(() {
      _model = ssd;
    });
    loadModel();
  }

  void goMap(BuildContext context) async {
    try {
      Navigator.pushNamed(context, MapTracker.id);
    } catch (e) {
      print(e);
    }
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _model = "";
              });
            }),
      ),
      backgroundColor: Colors.white,
      body: _model == ""
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.teal,
                    child: const Text(
                      'start',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => onSelect(),
                  ),
                  RaisedButton(
                    color: Colors.teal,
                    child: const Text(
                      'Map',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () => goMap(context),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                ),
                // MapTracker(),
              ],
            ),
    );
  }
}
