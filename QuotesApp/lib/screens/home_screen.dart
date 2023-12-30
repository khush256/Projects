import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quotesapp/screens/second_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
             style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300], foregroundColor: Colors.white),
              onPressed: () async {
                var url = Uri.parse(
                    'https://api.quotable.io/random?tags=technology%2Cfamous-quotes');
                var response = await http.get(url);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                var data = jsonDecode(response.body);
                String quote = data["content"];
                String author = data["author"];
                
                
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SecondScreen(quoteText: quote, authorName: author,)));
              },
              child: const Text("Get quote")),
        ),
      ),
    );
  }
}
