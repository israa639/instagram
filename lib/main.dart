import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/profile_bloc/profile_bloc.dart';
import 'package:untitled/bloc/search_user_bloc/search_users_bloc.dart';
import 'package:untitled/presentation/screens/login_screen.dart';
import 'package:untitled/presentation/screens/profile_screen.dart';
import 'package:untitled/presentation/screens/search_screen.dart';
import 'package:untitled/presentation/screens/timeLine_screen.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'bloc/comment_bloc/comment_bloc.dart';
import 'bloc/post_bloc/post_bloc.dart';
import 'bloc/profile_bloc/profile_bloc.dart';
import 'bloc/user_profile_image/profile_image_bloc.dart';
import 'data/models/user.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/comment_repository.dart';
import 'data/repository/post_repository.dart';
import 'data/repository/userProfileManagementRepository.dart';
import 'data/repository/user_actions_repository.dart';
import 'data/repository/user_repository.dart';
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
    return MultiRepositoryProvider(providers: [RepositoryProvider(
        create: (context) => AuthRepository())
      ,RepositoryProvider(
    create: (context) => UserRepository()),
      RepositoryProvider(
          create: (context) => PostRepository()),
    RepositoryProvider(
    create: (context) => UserActivitiesRepository()),
    RepositoryProvider(
    create: (context) => UserProfileManagemetRepository()),
      RepositoryProvider(
          create: (context) =>  commentRepository()),
    ],

      child: MultiBlocProvider(
        providers: [BlocProvider<AuthBloc>(create: (context) => AuthBloc(userProfileRepo: UserProfileManagemetRepository(),authRepository: RepositoryProvider.of<AuthRepository>(context),user_repository: RepositoryProvider.of<UserRepository>(context) ),),
          BlocProvider<BottomNavBarBloc>(create: (context) => BottomNavBarBloc(authRepository: RepositoryProvider.of<AuthRepository>(context))),
          BlocProvider<SearchUsersBloc>(create: (context) => SearchUsersBloc( userRepository: RepositoryProvider.of<UserRepository>(context),userProfileRepo: UserProfileManagemetRepository())),
          BlocProvider<ProfileImageBloc>(create: (context) =>ProfileImageBloc(authRepository: RepositoryProvider.of<AuthRepository>(context),current_user: RepositoryProvider.of<AuthRepository>(context).current_user)),
   BlocProvider<PostBloc>(create: (context) => PostBloc(postRepo: RepositoryProvider.of<PostRepository>(context),currentUser:RepositoryProvider.of<AuthRepository>(context).current_user,postNo:RepositoryProvider.of<AuthRepository>(context).current_user.posts_id==null?0:RepositoryProvider.of<AuthRepository>(context).current_user.posts_id!.length,userActivityRepo:RepositoryProvider.of< UserActivitiesRepository>(context),))
         , BlocProvider< CommentBloc>(create: (context) =>CommentBloc(commentRepo: commentRepository(),userProfileRepo: UserProfileManagemetRepository())),

          BlocProvider< ProfileBloc>(create: (context) =>ProfileBloc( current_user:RepositoryProvider.of<AuthRepository>(context).current_user,userProfileRepo: UserProfileManagemetRepository(),userActivityRepo:RepositoryProvider.of< UserActivitiesRepository>(context) )),

        ],


        child: MaterialApp(

          home: loginScreen (), //MyHomePage(),
          onGenerateRoute: appRouter.generate_route,
        ),
      ),
    );
  }
}
