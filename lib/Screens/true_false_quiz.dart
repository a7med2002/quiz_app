import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Screens/home.dart';
import 'package:quiz_app/modules/true%20false/true_false_brain.dart';
import 'package:quiz_app/widgets/custom_outline_btn.dart';
import 'package:quiz_app/widgets/custom_timer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TrueFalseQuiz extends StatefulWidget {
  final List<Color> colors;
  const TrueFalseQuiz({super.key, required this.colors});

  @override
  State<TrueFalseQuiz> createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  TrueFalseBrain tfBrain = TrueFalseBrain();

  int? selectedIndex;
  int numberOfCorrect = 0;

  int timeLeft = 10;
  Timer? countdownTimer;
  List<String> options = ["True", "False"];

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timeLeft = 10;

    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft > 0) {
        await audioPlayer.play(AssetSource("sounds/tick.mp3"));
        setState(() {
          timeLeft--;
        });
      } else {
        if (tfBrain.isFinished()) {
          handleFinishedQuiz();
        } else {
          setState(() {
            tfBrain.nextQuestion();
            timeLeft = 10;
          });
        }
      }
    });
  }

  void handleUserAnswer(int index) {
    setState(() {
      selectedIndex = index;
      if (options[index].toLowerCase() ==
          tfBrain.getQuestionAnswer().toString())
        ++numberOfCorrect;
    });
    if (tfBrain.isFinished()) {
      handleFinishedQuiz();
    } else {
      Future.delayed(
        Duration(seconds: 1),
        () => setState(() {
          selectedIndex = null;
          tfBrain.nextQuestion();
          timeLeft = 10;
        }),
      );
    }
  }

  void handleFinishedQuiz() {
    countdownTimer?.cancel();
    audioPlayer.stop();
    Future.delayed(
      Duration(seconds: 1),
      () => Alert(
        context: context,
        title: "T & F Quiz Finished",
        desc:
            "Your Score ${numberOfCorrect} / ${tfBrain.getNumberOfQuestions()}",
        style: AlertStyle(backgroundColor: Colors.white),
        buttons: [
          DialogButton(
            color: widget.colors[0],
            child: Text("Go to Home", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (route) => false,
              );
              setState(() {
                numberOfCorrect = 0;
              });
            },
          ),
        ],
      ).show(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlineBtn(
                    icon: Icons.close,
                    size: 24,
                    iconColor: Colors.white,
                  ),
                  CustomTimer(timeLeft: timeLeft),
                  CustomOutlineBtn(
                    icon: Icons.favorite,
                    size: 24,
                    iconColor: Colors.white,
                  ),
                ],
              ),
              Image.asset("assets/images/boat.png", width: 200, height: 200),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "question ${tfBrain.questionNumber + 1} of ${tfBrain.getNumberOfQuestions()}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    tfBrain.getQuestionText(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return ElevatedButton(
                    onPressed: (isSelected || selectedIndex != null)
                        ? () {}
                        : () => handleUserAnswer(index),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      backgroundColor: isSelected
                          ? (options[index].toLowerCase() ==
                                    tfBrain.getQuestionAnswer().toString()
                                ? Colors.green
                                : Colors.red)
                          : Colors.white,
                      foregroundColor: isSelected
                          ? Colors.white
                          : widget.colors[0],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (isSelected) SizedBox(width: 2),
                          Text(options[index], style: TextStyle(fontSize: 16)),
                          if (isSelected)
                            Icon(
                              options[index].toLowerCase() ==
                                      tfBrain.getQuestionAnswer().toString()
                                  ? Icons.check
                                  : Icons.close,
                              color: Colors.white,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
