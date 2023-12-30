// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constraints.dart';
import '../models/question_models.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';
import '../models/db_connect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBconnect();
  // final List<Question> _questions = [
  //   Question(
  //     id: '10',
  //     title: 'What is 2 + 2 ?',
  //     options: {'5': false, '30': false, '4': true, '10': false},
  //   ),
  //   Question(
  //     id: '10',
  //     title: 'What is 2 + 3 ?',
  //     options: {'5': true, '30': false, '4': false, '10': false},
  //   ),
  // ];
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You havn't selected any option"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text(
                  'Quiz App',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      'Score: $score',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    QuestionWidget(
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestions: extractedData.length),
                    const Divider(color: neutral),
                    // add some space
                    const SizedBox(height: 25.0),
                    for (int i = 0; i < extractedData[index].options.length; i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index].options.values.toList()[i] ==
                                      true
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child:  Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10.0),
                 child: NextButton(

                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        }
        else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                  'Questions loading...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
