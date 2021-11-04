import 'dart:async';

import 'package:camera/camera.dart';
import 'package:drushti/login-Page/routes/login.dart';
import 'package:drushti/source/object_detection/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:location/location.dart';

import 'source/Map/home.dart';

// import 'package:geolocator/geolocator.dart';

List<CameraDescription> cameras;
List<MapBoxNavigation> mapbox;
Location location = new Location();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogIn = false;
  void getCurrentUser() async {
    try {
      LocationData _locationData = await location.getLocation();
      print(_locationData);
      final _user = _auth.currentUser;
      if (_user != null) {
        isLogIn = true;
        print("Logged IN");
      } else {
        isLogIn = false;
        print("User is not Logged in");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RealTime Detection',
        initialRoute: isLogIn == true ? HomePage.id : Login.id,
        routes: {
          Login.id: (context) => Login(),
          HomePage.id: (context) => HomePage(cameras),
          MapTracker.id: (context) => MapTracker(),
        });
  }
}
