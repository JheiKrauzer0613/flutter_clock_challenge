import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digital_clock_official/digitalclock.dart';

  void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIOverlays([]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
     statusBarColor: Colors.transparent,
     systemNavigationBarColor: Colors.transparent
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight]).then((_){
    runApp(new DigitalClock());
    },
   );
  }

  class DigitalClock extends StatelessWidget {
    Widget build(BuildContext context) {
      return MaterialApp(
        home: DigitalClockUI()
      );
    }
  }