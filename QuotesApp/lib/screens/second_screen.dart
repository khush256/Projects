import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  String quoteText;
  String authorName;

  SecondScreen({Key? key, required this.authorName, required this.quoteText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(quoteText, style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(right:10),
            child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "-$authorName",
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ]),
      ),
    );
  }
}
