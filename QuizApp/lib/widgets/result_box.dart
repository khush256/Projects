// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import '../constraints.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onPressed
    });
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score',
              style: TextStyle(
                color: neutral,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 20.0),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                 style: TextStyle(fontSize: 30.0)
                 ),
              radius: 70.0,
              backgroundColor: result == questionLength/2
                ? Colors.yellow
                : result < questionLength/2 
                    ? incorrect 
                    : correct,
            ),
            const SizedBox(height: 20.0),
            Text( result == questionLength/2
                ? 'Almost There'
                : result < questionLength/2 
                    ? 'Try Again ?' 
                    : 'Great!',
                    style: TextStyle(color: neutral),
            ),
            const SizedBox(height: 25.0,),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                'Start Over',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  letterSpacing: 1.0
                ),
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
