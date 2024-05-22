import 'package:flutter/material.dart';
import 'package:node/constants/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text,style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50),
      backgroundColor: GlobalVariables.secondaryColor,

      ),

    );
  }
}
