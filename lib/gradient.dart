import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


  class AnimatedBackground extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      final tween = MultiTrackTween([
        Track("color1").add(Duration(seconds: 5), ColorTween(begin: Color(0xff00dbde), end: Color(0xfffc00ff))),
        Track("color2").add(Duration(seconds: 5), ColorTween(begin: Color(0xfffc00ff), end: Color(0xff00dbde)))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [animation["color1"], animation["color2"]]
            ),
            shape: BoxShape.circle
          ),
        );
      },
    );
   }
  }