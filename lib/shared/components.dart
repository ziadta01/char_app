import 'package:flutter/material.dart';

Widget defaultButton({
  required String? text,
  Color? textColor = Colors.black,
  required void Function()? onPress,
  required Color? backgroundColor,
}) {
  return Material(
    borderRadius: BorderRadius.circular(5),
    color: backgroundColor,
    elevation: 5.0,
    child: SizedBox(
      width: 300.0,
      height: 40.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        child: MaterialButton(
          onPressed: onPress,
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget defaultFromField({
  required Function(String?)? onChanged,
  required String? textHint,
  required Icon? prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
  required TextInputType? type,
  TextEditingController? controller,
}) {
  return TextField(
    obscureText: isPassword,
    controller: controller,
    textAlignVertical: TextAlignVertical.center,
    keyboardType: type,
    onChanged: onChanged,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: textHint!,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 3.0,
          color: Colors.deepOrange,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
  );
}

Widget defaultMessage({
  required String? sender,
  required String? text,
  required bool? isMe,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 20,
    ),
    child: Column(
      crossAxisAlignment: isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          "$sender",
        ),
        const SizedBox(
          height: 5,
        ),
        Material(
          elevation: 5.0,
          borderRadius: isMe ? const BorderRadius.only(
             topLeft: Radius.circular(30),
             bottomLeft: Radius.circular(30),
             bottomRight: Radius.circular(30),
          ) : const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: isMe ? Colors.blueAccent : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Text(
              '$text',
              style: TextStyle(
                fontSize: 15.0,
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
