import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Image.asset('images/bird.png'),
    );
  }
}