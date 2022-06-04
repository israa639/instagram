//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../data/repository/auth_repository.dart';

class ProfileScreen extends StatefulWidget {



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File ProfileImage=File('');
  String imagePath='';
  @override
  Widget build(BuildContext context) {

    return  Scaffold(






    );
  }


}
