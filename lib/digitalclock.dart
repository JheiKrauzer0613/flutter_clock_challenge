import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digital_clock_official/particles.dart';
import 'package:digital_clock_official/gradient.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:digital_clock_official/waves.dart';
import 'dart:math';
import 'dart:async';

class DigitalClockUI extends StatefulWidget {
  _DigitalClockUIState createState() => _DigitalClockUIState();
}

class _DigitalClockUIState extends State<DigitalClockUI> {
  static double _blockSizeHorizontal;
  static double _blockSizeVertical;
  String _hourString;
  String _minString;
  String _dayString;
  String _marker;
  Color _bgColor1 = new Color(0xffB7F8DB);
  Color _bgColor2 = new Color(0xff50A7C2);
  int _currHour = 0;
  Timer _timer;

  @override
  void initState() {
    _hourString = formatHour(new DateTime.now());
    _minString = formatMinute(new DateTime.now());
    _dayString = formatDay(new DateTime.now());
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer t) => _getTimeAndBackground());
    super.initState();
  }

  void _getTimeAndBackground() {
    final String formattedHour = formatHour(new DateTime.now());
    final String formattedMin = formatMinute(new DateTime.now());
    final String formattedDay = formatDay(new DateTime.now());
    setState(() {
      _hourString = formattedHour;
      _minString = formattedMin;
      _dayString = formattedDay;

      _currHour = int.parse(_hourString);
      if(_currHour >= 0 && _currHour <= 5){
        _bgColor1 = new Color(0xffB06AB3);
        _bgColor2 = new Color(0xff4568DC);
        _marker = "Morning";
      }
      else if(_currHour >= 6 && _currHour <= 11){
        _bgColor1 = new Color(0xffB9ECFF);
        _bgColor2 = new Color(0xff2F80ED);
        _marker = "Morning";
      }
      else if(_currHour >= 12 && _currHour <= 17){
        _bgColor1 = new Color(0xffFFC086);
        _bgColor2 = new Color(0xffDD335B);
        _marker = "Afternoon";
      }
      else if(_currHour >= 18 && _currHour <= 24) {
        _bgColor1 = new Color(0xff8F66AB);
        _bgColor2 = new Color(0xff2A0845);
        _marker = "Evening";
      }
      else {
        _bgColor1 = new Color(0xffB7F8DB);
        _bgColor2 = new Color(0xff50A7C2);
        _marker = "Day";
      }

    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatHour(DateTime _dtHour) {
    return DateFormat('HH').format(_dtHour);
  }

  String formatMinute(DateTime _dtMin) {
    return DateFormat('mm').format(_dtMin);
  }

  String formatDay(DateTime _dtDay) {
    return DateFormat('EEEE').format(_dtDay);
  }

  Widget build(BuildContext context) {
    _blockSizeHorizontal = MediaQuery.of(context).size.width  / 100;
    _blockSizeVertical = MediaQuery.of(context).size.height  / 100;

    onBottom(Widget child) => Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: child,
      ),
    );

    return new Center(
      child: new AspectRatio(
        aspectRatio: 5 / 3,
        child: new Container(
          color: Colors.black45,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new AnimatedContainer(
                      duration: Duration(seconds: 2),
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [_bgColor1, _bgColor2]
                        ),
                      ),
                      child: new Stack(
                        children: <Widget>[
                          new Positioned.fill(child: Particles(13)),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: new Container(
                              width: _blockSizeHorizontal * 26.0,
                              child: new Text(
                                _hourString,
                                textAlign: TextAlign.right,
                                style: new TextStyle(
                                  fontFamily: 'RussoOne',
                                  fontSize: _blockSizeHorizontal * 18.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white.withOpacity(0.4)
                                ),
                              ),
                            ),
                          ),
                          new Align(
                            alignment: Alignment.bottomRight,
                            child: new Container(
                              padding: EdgeInsets.only(left: 30.0, bottom: 20.0),
                              width: _blockSizeHorizontal * 100.0,
                              child: new Text(
                                _marker,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                    fontFamily: 'RussoOne',
                                    fontSize: _blockSizeHorizontal * 6.5,
                                    decoration: TextDecoration.none,
                                    color: Colors.white.withOpacity(0.4)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffB7F8DB), Color(0xff50A7C2)]
                        ),
                      ),
                      child: new Stack(
                        children: <Widget>[
                          new Positioned.fill(child: Particles(13)),
                          new Align(
                            alignment: Alignment.bottomRight,
                            child: new Container(
                              width: _blockSizeHorizontal * 26.0,
                              child: new Text(
                                _minString,
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontFamily: 'RussoOne',
                                  fontSize: _blockSizeHorizontal * 18.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white.withOpacity(0.4)
                                ),
                              ),
                            ),
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: new Container(
                              padding: EdgeInsets.only(right: 30.0, top: 20.0),
                              width: _blockSizeHorizontal * 100.0,
                              child: new Text(
                                'Wednesday',
                                textAlign: TextAlign.right,
                                style: new TextStyle(
                                    fontFamily: 'RussoOne',
                                    fontSize: _blockSizeHorizontal * 6.5,
                                    decoration: TextDecoration.none,
                                    color: Colors.white.withOpacity(0.4)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onBottom(AnimatedWave(height: 115, speed: 1.0, offset: pi / 2)),
              onBottom(AnimatedWave(height: 115, speed: 1.0, offset: pi)),
              new Center(
                child: new Container(
                  height: _blockSizeVertical * 72.0,
                  width: _blockSizeHorizontal * 72.0,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xff202020).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: new AnimatedBackground(),
                ),
              ),
              new Center(
                child: new Container(
                  height: _blockSizeVertical * 67.0,
                  width: _blockSizeHorizontal * 67.0,
                  decoration: new BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: new FlutterAnalogClock(
                    dateTime: DateTime.now(),
                    dialPlateColor: Colors.white,
                    hourHandColor: Color(0xff303030),
                    minuteHandColor: Color(0xff707070),
                    secondHandColor: Colors.red,
                    borderColor: Colors.white,
                    tickColor: Color(0xff2F80ED),
                    centerPointColor: Colors.black,
                    showBorder: true,
                    showTicks: true,
                    showMinuteHand: true,
                    showSecondHand: true,
                    showNumber: false,
                    borderWidth: 8.0,
                    isLive: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}