import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hintText == "Password" ? true : false,
      validator: (data){
        if(data!.isEmpty){
          return "Please enter $hintText";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
