import 'package:chat_app/modules/chat_screen.dart';
import 'package:chat_app/modules/register_screen.dart';
import 'package:chat_app/modules/signin_screen.dart';
import 'package:chat_app/modules/welcome_screen.dart';
import 'package:chat_app/shared/bloc/bloc.dart';
import 'package:chat_app/shared/bloc/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: cubit.auth.currentUser != null ? ChatScreen.routeTitle : WelcomeScreen.routeTitle,
            routes: {
              WelcomeScreen.routeTitle : (context) => const WelcomeScreen(),
              SignInScreen.routeTitle : (context) => const SignInScreen(),
              RegisterScreen.routeTitle : (context) => const RegisterScreen(),
              ChatScreen.routeTitle : (context) => const ChatScreen(),
            },
          );
        },
      ),
    );
  }
}
