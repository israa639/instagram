import 'package:flutter/material.dart';
class Myfollowers extends StatefulWidget {



  @override
  State<Myfollowers > createState() => _MyfollowersState();
}

class _MyfollowersState extends State<Myfollowers> {
  int currentIndx=0;

  String userName='israa!';
  Container makeProgramContainer(){
    return Container(
      height: 200,
      width:300,
      decoration: BoxDecoration(

          borderRadius:BorderRadius.all(Radius.circular(20.0)),
          color: Colors.blue.shade100,
          boxShadow:[ BoxShadow(color: Colors.grey,blurRadius: 10.0),]
      ),
    );

  }
  Container makeContainer(AlignmentGeometry a,String text,double fontSize,Color c){
    return Container(
      alignment:a,
      child: Text(text,
        style: TextStyle(fontSize: fontSize,color: c),
      ),);}
  BottomNavigationBarItem makeNavigationButton(String Btnlabel,IconData icon1)
  {
    return  BottomNavigationBarItem(
      icon:Icon( icon1),
      label: Btnlabel,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:

      Column(children:<Widget>[
        SizedBox(height: 50,),
        Container(
          alignment: Alignment.center,
          height: 40,
          child:
          Image.asset('lib/icons/lotus.png'),

        ),
        makeContainer(Alignment.center,'YogAi',20,Colors.blue),

        Row(children:<Widget>[
          makeContainer(Alignment.centerLeft,' Hi,',40,Colors.black),
          makeContainer(Alignment.centerLeft,userName,40, Colors.redAccent.shade200),
        ]),
        makeContainer(Alignment.centerLeft,'   beginner Level',20, Colors.black),
        SizedBox(height: 50,),
        Container(
            height: 200,
            child:
            ListView(scrollDirection: Axis.horizontal,
              children:[
                makeProgramContainer(),
                SizedBox(width: 20,),
                makeProgramContainer(),
                SizedBox(width: 20,),
                makeProgramContainer(),
              ],)
        ),
      ],),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        currentIndex: currentIndx,
        onTap: (index) =>setState(() => currentIndx =index),
        selectedItemColor: Colors.white
        ,
        items: [
          makeNavigationButton('home',Icons.home),
          makeNavigationButton('search',Icons.search),
          makeNavigationButton('profile',Icons.person),






        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

