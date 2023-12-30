import 'package:flutter/material.dart';
import '../constraints.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: const Text(
        'Next Question',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      )
    );
  }
}