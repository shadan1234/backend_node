import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton(
      {Key? key, required this.text, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(color: color==null? Colors.white:Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        // back
      
        minimumSize: Size(double.infinity, 50),
        backgroundColor: color==null? GlobalVariables.secondaryColor:color,
      ),
    );
  }
}
