
import 'package:flutter/material.dart';
import 'package:wiifd/utilties/app_colors.dart';

class TodoTextInput extends StatelessWidget {
  final TextEditingController? textController;
  final String? hint;
  final double? textFieldHeight;

  TodoTextInput({this.textController, this.hint,this.textFieldHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: textFieldHeight,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: AppColor().greyColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(9),
            border: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
