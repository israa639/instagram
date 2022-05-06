import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/screens/login_screen.dart';
import 'package:untitled/presentation/screens/profile_screen.dart';
import 'package:untitled/presentation/screens/search_screen.dart';
import 'package:untitled/presentation/screens/timeLine_screen.dart';
import 'bloc/auth_bloc.dart';
import 'data/repository/auth_repository.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
        child: MaterialApp(

          home: loginScreen(), //MyHomePage(),
          onGenerateRoute: appRouter.generate_route,
        ),
      ),
    );
  }
}

class MyHomeBar extends StatefulWidget {


  @override
  State<MyHomeBar> createState() => _MyHomeBarState();
}

class _MyHomeBarState extends State<MyHomeBar> {
  int currentIndx = 0;
  String title = 'instagram';
  List screens = [
    //loginScreen(),

    HomeScreen(),
    searchScreen(),
    ProfileScreen(),


  ];

  BottomNavigationBarItem makeNavigationButton(String Btnlabel,
      IconData icon1) {
    return BottomNavigationBarItem(
      icon: Icon(icon1),
      label: Btnlabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndx],


      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndx,
        onTap: (index) => setState(() => currentIndx = index),
        selectedItemColor: Colors.black
        ,
        items: [
          makeNavigationButton('home', Icons.home),
          makeNavigationButton('search', Icons.search),
          makeNavigationButton('profile', Icons.person),


        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

