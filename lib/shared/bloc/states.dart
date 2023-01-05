import 'package:flutter/material.dart';

abstract class AppState {}

class AppInitialState extends AppState {}

class ChangePasswordView extends AppState {}

class RegisterLoading extends AppState {}

class RegisterSuccesses extends AppState {}

class RegisterFailed extends AppState {
  final String? error;

  RegisterFailed(this.error);
}

class LoginLoading extends AppState {}

class LoginSuccesses extends AppState {}

class LoginFailed extends AppState {
  final String? error;

  LoginFailed(this.error);
}

class SendMessageLoading extends AppState {}

class SendMessageSuccesses extends AppState {}

class SendMessageFailed extends AppState {
  final String? error;

  SendMessageFailed(this.error);
}

class GetMessageLoading extends AppState {}

class GetMessageSuccesses extends AppState {}

