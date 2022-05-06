import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
String title='instagram';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title,),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,

      ),
      body:Center(child:Text('HomePage'),),
    );
  }
}