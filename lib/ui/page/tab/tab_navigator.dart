import 'package:flutter/material.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: Text('首页的切换页面总页'),
      ),
    );
  }
}