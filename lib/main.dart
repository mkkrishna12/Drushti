import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'source/object_detection/home.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RealTime Detection',
      home: HomePage(cameras),
    );
  }
}
