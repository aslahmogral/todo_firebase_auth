import 'package:flutter/material.dart';
import 'package:todo_mtest/utils/apptheme.dart';
import 'package:todo_mtest/utils/colors.dart';

class TodoButton extends StatefulWidget {
  final void Function()? onPressed;
  final String label;
  final Color? buttonColor;
  final Color? textColor;
  final bool gradient;
  const TodoButton(
      {super.key,
      this.onPressed,
      required this.label,
      this.buttonColor,
      this.textColor,
      required this.gradient});

  @override
  State<TodoButton> createState() => W_ButtonState();
}

class W_ButtonState extends State<TodoButton> {
  var offsetBoxShadow = [
    BoxShadow(
      offset: Offset(-8.0, -8.0),
      color: todoColors.brightColor,
      blurRadius: 10.0,
    ),
    BoxShadow(
      offset: Offset(8.0, 8.0),
      color: todoColors.darkColor,
      blurRadius: 10.0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: offsetBoxShadow,
          gradient: widget.gradient ? TodoTheme.primaryGradient : null,
          color: widget.gradient
              ? null
              : widget.buttonColor ?? todoColors.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Material(
        child: InkWell(
            onTap: widget.onPressed,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                      color: widget.textColor ?? todoColors.dimWhiteColor),
                ),
              ),
            )),
        color: Colors.transparent,
      ),
    );
  }
}
