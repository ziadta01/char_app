import 'package:chat_app/shared/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isShow = true;

  bool showHUD = false;

  String? textMessage;

  List<Widget> messagesWidgets = [];

  var messageController = TextEditingController();

  void changePassField() {
    isShow = !isShow;
    emit(ChangePasswordView());
  }

  void navigator(BuildContext context, String? route) {
    Navigator.pushNamed(context, route!);
  }

  final auth = FirebaseAuth.instance;

  final store = FirebaseFirestore.instance;

  String? email;
  String? password;

  late User signedInUser;

  Future registerUser() async {
    showHUD = true;
    emit(RegisterLoading());
    final newUser = await auth
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      print(value);
      showHUD = false;
      emit(RegisterSuccesses());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterFailed(error));
    });
  }

  Future loginUser() async {
    showHUD = true;
    emit(LoginLoading());
    final newUser = await auth
        .signInWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      showHUD = false;
      print(value);
      emit(LoginSuccesses());
    }).catchError((error) {
      print(error.toString());
      emit(LoginFailed(error));
    });
  }

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (value) {
      print(value);
    }
  }

  Future sendMessage() async {
    emit(SendMessageLoading());
    store.collection('messages').add({
      'sender': signedInUser.email,
      'text': textMessage,
      'time': FieldValue.serverTimestamp(),
    }).then((value) {
      print(value);
      emit(SendMessageSuccesses());
    }).catchError((error) {
      print(error);
      emit(SendMessageFailed(error));
    });
  }

  Future getMessage() async {
    emit(GetMessageLoading());
    await for (var snapshots in store.collection('messages').snapshots()) {
      for (var message in snapshots.docs) {
        print(message.data());
        emit(GetMessageSuccesses());
      }
    }
  }
}
