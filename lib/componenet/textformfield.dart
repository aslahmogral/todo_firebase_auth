import 'package:flutter/material.dart';
import 'package:todo_mtest/utils/colors.dart';
import 'package:todo_mtest/utils/dimens.dart';

class TodoTextFormField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  const TodoTextFormField(
      {super.key,
      this.textEditingController,
      this.label,
      this.hintText,
      this.textInputType, this.validator});

  @override
  State<TodoTextFormField> createState() => _TodoTextFormFieldState();
}

class _TodoTextFormFieldState extends State<TodoTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.textEditingController,
      validator: widget.validator,
      decoration: InputDecoration(
        
          fillColor: todoColors.brightColor,
          filled: true,
          label: Text(
            widget.label.toString(),
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.borderRadius_small),
              borderSide: BorderSide(color: todoColors.primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.borderRadius_small),
              borderSide: BorderSide(color: todoColors.primaryColor))),
    );
  }
}
