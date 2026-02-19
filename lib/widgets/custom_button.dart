import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text,required this.onTap});

  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF2B475E),
            ),
          ),
        ),
      ),
    );
  }
}
