import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/profile_bloc/profile_bloc.dart';
import 'package:untitled/presentation/screens/login_screen.dart';
import 'package:untitled/presentation/screens/profile_screen.dart';
import 'package:untitled/presentation/screens/search_screen.dart';
import 'package:untitled/presentation/screens/timeLine_screen.dart';

import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../bloc/post_bloc/post_bloc.dart';
import 'add_post_screen.dart';


class MyHomeBar extends StatefulWidget {


  @override
  State<MyHomeBar> createState() => _MyHomeBarState();
}

class _MyHomeBarState extends State<MyHomeBar> {


  BottomNavigationBarItem makeNavigationButton(String Btnlabel,
      IconData icon1) {
    return BottomNavigationBarItem(
      icon: Icon(icon1),

      label: Btnlabel,
    );
  }

  late File imageFile;

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBloc = BlocProvider.of<BottomNavBarBloc>(context);

    return Scaffold(

      body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          bloc: bottomNavigationBloc,
          builder: (BuildContext context, BottomNavBarState state) {
            if (state is PageLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is HomePageLoaded) {
              return HomeScreen();
            }
            if (state is ProfilePageLoaded) {
              return ProfileScreen();
            }
            if (state is SearchPageLoaded) {
              return searchScreen();
            }
            if (state is AddPostPageLoaded) {
              return addPostScreen(imageFile);
              /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>addPostScreen(imageFile)),
              );*/
            }
            return Container();
          }
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          bloc: bottomNavigationBloc,
          builder: (BuildContext context, BottomNavBarState state) {
            return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: bottomNavigationBloc.current_index,
                items: <BottomNavigationBarItem>[
                  makeNavigationButton('home', Icons.home),
                  makeNavigationButton('search', Icons.search),
                  makeNavigationButton('add post', Icons.add_box_outlined),
                  makeNavigationButton(
                      'favourite', Icons.heart_broken_outlined),
                  makeNavigationButton('profile', Icons.person),
                ],

                onTap: (index) {
                  if (index == 2) {
                    getImage(source: ImageSource.camera,);
                    // setState(()=>index=4);
                  }
                  bottomNavigationBloc.add(PageTapped(index: index,
                      current_user: bottomNavigationBloc.authRepository
                          .current_user));
                }


            );
          }
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    setState(() => imageFile = File(file!.path));
    /* if(file?.path!=null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>addPostScreen(imageFile)),
      );
    }*/

  }
}
