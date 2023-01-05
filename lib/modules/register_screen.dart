// ignore_for_file: must_be_immutable

import 'package:chat_app/modules/chat_screen.dart';
import 'package:chat_app/shared/bloc/bloc.dart';
import 'package:chat_app/shared/bloc/states.dart';
import 'package:chat_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeTitle = 'register_screen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: cubit.showHUD,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              backgroundColor: Colors.white,
              body: Center(
                child: SingleChildScrollView(
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
                          height: 20,
                        ),
                        defaultFromField(
                          type: TextInputType.emailAddress,
                          onChanged: (value) {
                            cubit.email = value!;
                          },
                          textHint: 'Enter Your Email',
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFromField(
                          type: TextInputType.visiblePassword,
                          onChanged: (value) {
                            cubit.password = value!;
                          },
                          textHint: 'Enter Your Password',
                          prefixIcon: const Icon(Icons.lock),
                          isPassword: cubit.isShow,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePassField();
                            },
                            icon: cubit.isShow
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          text: 'Register',
                          onPress: () {
                            FocusScope.of(context).unfocus();
                            cubit.registerUser().then((value) =>
                                cubit.navigator(context, ChatScreen.routeTitle));
                          },
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
