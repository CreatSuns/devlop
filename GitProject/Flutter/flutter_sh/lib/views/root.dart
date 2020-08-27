import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttersh/views/home.dart';
import 'package:fluttersh/views/mine.dart';
import 'package:fluttersh/views/square.dart';


class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int currentIndex = 0;
  var _body;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void initData() {
    _body = IndexedStack(
      children: <Widget>[Home(), Square(), Mine()],
      index: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
//              activeIcon: Image(
//                image: AssetImage('images/icon_shouye_press.png'),
//              ),
              title: Text('首页'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new),
//              activeIcon:
//              Image(image: AssetImage('images/icon_sucai_press.png')),
              title: Text('广场'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_location),
//              activeIcon: Image(image: AssetImage('images/icon_me_press.png')),
              title: Text('我的'),
            ),
          ],
          onTap: changeIndex,
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
//        elevation: 10.0,
//        type: BottomNavigationBarType.fixed,
//      fixedColor: Colors.red,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          iconSize: 20,
        ),
        body: _body,
    );
  }
}
