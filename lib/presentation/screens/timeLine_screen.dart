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
      body:Column(children:<Widget>[
Container(
   child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                leading: Icon(Icons.list),
                trailing: Text("GFG",
                  style: TextStyle(
                      color: Colors.green,fontSize: 15),),
                title:Text("List item $index")
            );}
   ), ),])
    );
  }
}