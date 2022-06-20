
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/screens/profile_screen.dart';
import 'package:untitled/presentation/screens/searchResult_screen.dart';

import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../bloc/search_user_bloc/search_users_bloc.dart';
import '../../data/models/user.dart';
import 'login_screen.dart';

class searchScreen extends StatefulWidget {


  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  final _nameController=TextEditingController();
  @override
  void dispose() {

    _nameController.dispose();
    super.dispose();
  }
/*Widget makeListView()
{

}*/
  @override
  Widget build(BuildContext context) {
    final _ProfileBloc=BlocProvider.of<ProfileBloc>(context);
    final _searchResultBloc=BlocProvider.of<SearchUsersBloc>(context);
    return Scaffold(

      backgroundColor: Colors.white70,
      body: Column(children:<Widget>[
      Padding(padding: EdgeInsets.only(top:30,)),


    TextField(
      textAlign: TextAlign.center,
    //icon:Icon(Icons.search),
    decoration:InputDecoration(fillColor:Colors.white,filled: true,hintText: 'search ',

    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))) ,
    onChanged:(text){searchScreen( context,text);

        },
    ),




    BlocBuilder< SearchUsersBloc, SearchUsersState>(
            bloc: _searchResultBloc,
              builder: (BuildContext context, SearchUsersState state) {
                  if (state is SearchStateLoading) {
                      return  CircularProgressIndicator();
                        }
                   if (state is SearchStateError) {
                      return Text(state.error);
                            }
                      if (state is SearchStateSuccess && state.search_result.length>0) {
                        return Expanded(

                            child: ListView.builder(
                              itemCount: state.search_result.length,

                              itemBuilder: ( context, int index) {

                                return Container(

                                  child: Row(
                                    children: [
                                      FutureBuilder(future:state.search_result[index].profile_img_downloaded_url,
                                      builder: (context,snapshot){
                                        if(snapshot.connectionState==ConnectionState.done)
                                        { if (snapshot.hasData) {
                                          return CircleAvatar(radius:20,

                                            backgroundImage: NetworkImage("${snapshot.data.toString()}"),
                                          );}

                                        }return CircleAvatar(radius:20,
                                          backgroundColor: Colors.grey,);

                                      }),
                                      TextButton(
                                          child:Text(state.search_result[index].username),
                                          onPressed:() {
                                            _ProfileBloc.add(RequestLoadPosts(state.search_result[index]));

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) =>
                                                    SearchProfileScreen(state.search_result[index],_ProfileBloc)));
                                            _searchResultBloc.add(searchFinished());

                                          }),
                                      // Text(state.search_result[index].username,),
                                    ],


                                  ),
                                );}
                              ,));


                      }
                      else{

                        return Container(
                        );

                      }

            }),



      ])




    );

  }
  void searchScreen(BuildContext context,String username){
  BlocProvider.of<SearchUsersBloc>(context).add(
      TextChanged(user_name: username));
  }
}
