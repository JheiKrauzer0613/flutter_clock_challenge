import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:digital_clock_official/particles.dart';
import 'package:digital_clock_official/screenscale.dart';
import 'package:digital_clock_official/gradient.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:digital_clock_official/waves.dart';
import 'dart:math';
import 'dart:async';

  class DigitalClockUI extends StatefulWidget {
    _DigitalClockUIState createState() => _DigitalClockUIState();
  }

  class _DigitalClockUIState extends State<DigitalClockUI> {
    String _hourString;
    String _minString;
    String _dayString;
    String _dateString;
    Color _bgColor1 = new Color(0xffB7F8DB);
    Color _bgColor2 = new Color(0xff50A7C2);
    int _currHour = 0;
    Timer _timer;

    @override
    void initState() {
      _hourString = formatHour(new DateTime.now());
      _minString = formatMinute(new DateTime.now());
      _dayString = formatDay(new DateTime.now());
      _dateString = formatDate(new DateTime.now());
      _timer = new Timer.periodic(Duration(seconds: 1), (Timer t) => _getTimeAndBackground());
      super.initState();
    }

    void _getTimeAndBackground() {
      final String formattedHour = formatHour(new DateTime.now());
      final String formattedMin = formatMinute(new DateTime.now());
      final String formattedDay = formatDay(new DateTime.now());
      final String formattedDate = formatDate(new DateTime.now());
      setState(() {
        _hourString = formattedHour;
        _minString = formattedMin;
        _dayString = formattedDay;
        _dateString = formattedDate;

        _currHour = int.parse(_hourString);
        if(_currHour >= 0 && _currHour <= 5){
          _bgColor1 = new Color(0xffB06AB3);
          _bgColor2 = new Color(0xff4568DC);
        }
        else if(_currHour >= 6 && _currHour <= 11){
          _bgColor1 = new Color(0xffB9ECFF);
          _bgColor2 = new Color(0xff2F80ED);
        }
        else if(_currHour >= 12 && _currHour <= 17){
          _bgColor1 = new Color(0xffFFC086);
          _bgColor2 = new Color(0xffDD335B);
        }
        else if(_currHour >= 18 && _currHour <= 24) {
          _bgColor1 = new Color(0xff8F66AB);
          _bgColor2 = new Color(0xff2A0845);
        }
        else {
          _bgColor1 = new Color(0xffB7F8DB);
          _bgColor2 = new Color(0xff50A7C2);
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

    String formatDate(DateTime _dtDate) {
      return DateFormat('MMMM dd, yyyy').format(_dtDate);
    }

    Widget build(BuildContext context) {
      onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

      SizeConfig().init(context);

      return new Stack(
        children: <Widget>[

          new Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            color: Colors.white,

            child: new Stack(
              children: <Widget>[

                new Align(
                  alignment: Alignment.centerLeft,
                  child: new ShapeOfView(
                    width: SizeConfig.blockSizeHorizontal*51.0,
                    height: SizeConfig.blockSizeVertical*100.0,
                    shape: new DiagonalShape(
                       position: DiagonalPosition.Right,
                       direction: DiagonalDirection.Left,
                       angle: DiagonalAngle.deg(angle: 6.1)
                    ),
                    child: new AnimatedContainer(
                      duration: Duration(seconds:2),
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [_bgColor1, _bgColor2]
                        ),
                      ),
                      child: new Container(
                        child: new Stack(
                          children: <Widget>[
                            Positioned.fill(child: Particles(13)),
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: new Container(
                                height: SizeConfig.blockSizeVertical * 100.0,
                                width: SizeConfig.blockSizeHorizontal * 30.0,
                                child: new Align(
                                  alignment: Alignment.topRight,
                                  child: new Text(_hourString,
                                    style: new TextStyle(
                                      fontFamily: 'RussoOne',
                                      fontSize: SizeConfig.blockSizeHorizontal* 20.0,
                                      decoration: TextDecoration.none,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ),


                new Align(
                  alignment: Alignment.centerRight,
                  child: new ShapeOfView(
                    width: SizeConfig.blockSizeHorizontal*55.0,
                    height: SizeConfig.blockSizeVertical*100.0,
                    shape: new DiagonalShape(
                        position: DiagonalPosition.Left,
                        direction: DiagonalDirection.Left,
                        angle: DiagonalAngle.deg(angle: 6.1)
                    ),
                    child: new AnimatedContainer(
                      duration: Duration(seconds:2),
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffB7F8DB), Color(0xff50A7C2)]
                        ),
                      ),
                      child: new Container(
                          child: new Stack(
                            children: <Widget>[
                              Positioned.fill(child:Particles(13)),
                              new Align(
                                alignment: Alignment.centerRight,
                                child: new Container(
                                  height: SizeConfig.blockSizeVertical * 100.0,
                                  width: SizeConfig.blockSizeHorizontal * 30.0,
                                  child: new Align(
                                    alignment: Alignment.bottomLeft,
                                    child: new Text(_minString,
                                      style: new TextStyle(
                                        fontFamily: 'RussoOne',
                                        fontSize: SizeConfig.blockSizeHorizontal* 20.0,
                                        decoration: TextDecoration.none,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ),


                  new Stack(
                    children: <Widget>[

                      new Align(
                        alignment: Alignment.bottomCenter,
                        child: new Container(
                          height: SizeConfig.screenHeight,
                          child: new Stack(
                            children: <Widget>[
                              onBottom(AnimatedWave(height: 115, speed: 1.0, offset: pi / 2)),
                              onBottom(AnimatedWave(height: 115, speed: 1.0, offset: pi)),
                            ],
                          ),
                        ),
                      ),

                      new Center(
                      child: new Container(
                        height: SizeConfig.blockSizeVertical * 80.0,
                        width: SizeConfig.blockSizeHorizontal * 80.0,
                        decoration: new BoxDecoration(
                           boxShadow: [new BoxShadow(
                             color: Color(0xff202020).withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 10,
                           )],
                           shape: BoxShape.circle,
                        ),
                        child: AnimatedBackground(),
                      ),
                     ),

                      new Center(
                        child: new Container(
                          height: SizeConfig.blockSizeVertical * 70.0,
                          width: SizeConfig.blockSizeHorizontal * 70.0,
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
              ],
            ),
          ),
        ],
      );
    }
  }

  //getCurrentMark(_markNow)