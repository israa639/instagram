import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/data/repository/auth_repository.dart';
import 'package:untitled/presentation/screens/profile_screen.dart';
import 'package:untitled/presentation/screens/timeLine_screen.dart';
import 'package:untitled/presentation/screens/timeLine_screen.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../../main.dart';
import 'Home_screen.dart';
import 'login_screen.dart';

class signUpScreen extends StatefulWidget {

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController=TextEditingController();
  final _nameController=TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {

            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) =>BlocProvider.value(
                  value: BlocProvider.of<BottomNavBarBloc>(context),
                  child:  MyHomeBar(),
                )));


          }
          if (state is AuthError) {

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {

            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "instagram",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                      !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              TextFormField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  hintText: "username",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value == null
                                      ? 'this username is already used'
                                      : null;
                                },
                              ),
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: "full-name",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value == null
                                      ? 'Enter a valid name'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText:true,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(),

                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;

                                },

                              ),
                              TextFormField(
                                obscureText:true,
                                decoration: const InputDecoration(
                                  hintText: "confirm-Password",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return  value!= _passwordController.text ||value==null
                                      ? "please make sure both passwords match"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _createAccountWithEmailAndPassword(context);
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      TextButton(
                          child:Text("Already have an account?"),
                          onPressed:() {
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) =>
                                  loginScreen()));

                          }),

                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }


  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
          _usernameController.text,
          _nameController.text,
        ),
      );
    }
  }}