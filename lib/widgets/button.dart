 // ignore_for_file: prefer_const_constructors

 import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child:   Center(
                        child: Text(text,style: TextStyle(fontSize: 18,
                         color: Colors.white,
                         fontWeight: FontWeight.w400),))
                    ),
                  );
  }
}