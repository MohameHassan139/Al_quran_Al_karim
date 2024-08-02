import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String labelText;
  Icon? prefixIcon;
  String? Function(String?)? validator;
  void Function(String)? onChange;
  IconButton? suffix;
  TextInputType? fieldType;
  TextEditingController? textController;
  bool? ispassword = false;
  void Function()? onTap;
  bool? readOnly = false;

  int? maxLines;
  int? minLines;
  CustomTextFormField({
    key,
    this.textController,
    this.onChange,
    this.suffix,
    this.validator,
    this.ispassword,
    this.fieldType,
    this.onTap,
    required this.labelText,
    this.prefixIcon,
    this.readOnly,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        minLines: minLines,
        keyboardAppearance: Brightness.dark,
        onTap: onTap,
        keyboardType: fieldType,
        validator: validator,
        onChanged: onChange,
        obscureText: ispassword ?? false,
        controller: textController,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          suffixIcon: suffix,
          fillColor: Color.fromARGB(49, 255, 255, 255),
          filled: true,
          prefixIcon: prefixIcon,
          labelText: '$labelText',
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),

          // focused border style
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),

          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10))),

          // error focused border style
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1,
          // color: CustomColors.kCyanColor,
        ),
      ),
    );
  }
}
