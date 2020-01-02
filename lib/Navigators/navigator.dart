
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../Screens/trackchange.dart';
import '../Screens/menu.dart';
import '../main.dart';

class navigation extends HomeScreenState{

    Future _homeToMenu1(BuildContext context){
        return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    }

    Future _homeToTrackChange(BuildContext context){
        return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrackChange()),
        );
    }

}

