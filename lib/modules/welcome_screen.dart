import 'package:chat_app/modules/register_screen.dart';
import 'package:chat_app/modules/signin_screen.dart';
import 'package:chat_app/shared/bloc/bloc.dart';
import 'package:chat_app/shared/bloc/states.dart';
import 'package:chat_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {

  static const String routeTitle = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/logo.png'),
                      height: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Message Me',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      backgroundColor: Colors.deepOrange,
                      text: "Sign in",
                      textColor: Colors.white,
                      onPress: () {
                        cubit.navigator(context, SignInScreen.routeTitle);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultButton(
                      backgroundColor: Colors.blueAccent,
                      text: "Register",
                      textColor: Colors.white,
                      onPress: () {
                        cubit.navigator(context, RegisterScreen.routeTitle);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}