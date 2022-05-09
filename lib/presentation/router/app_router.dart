import 'package:flutter/material.dart';
import '../../main.dart';
import '../screens/editProfile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/registeration_screen.dart';
class AppRouter{

  Route? generate_route(RouteSettings settings){

    switch(settings.name){
      case'signUp':
        return MaterialPageRoute(builder: (_)=>signUpScreen());
      case'home':
        return MaterialPageRoute(builder: (_)=>MyHomeBar());
      case'logout':
        return MaterialPageRoute(builder: (_)=>loginScreen());
      case'login':
        return MaterialPageRoute(builder: (_)=>loginScreen());
      case'editProfile':
        return MaterialPageRoute(builder: (_)=>UpdateProfileScreen());
    }

  }



}
