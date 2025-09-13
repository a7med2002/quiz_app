import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/Screens/home.dart';
import 'package:quiz_app/modules/multiple%20choice/multipe_choice_brain.dart';
import 'package:quiz_app/widgets/custom_outline_btn.dart';
import 'package:quiz_app/widgets/custom_timer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audioplayers.dart';

class MultipeScreen extends StatefulWidget {
  final List<Color> colors;
  const MultipeScreen({super.key, required this.colors});

  @override
  State<MultipeScreen> createState() => _MultipeScreenState();
}

class _MultipeScreenState extends State<MultipeScreen> {
  int? selectedIndex;
  int numberOfCorrect = 0;
  MultipeChoiceBrain multipeChoiceBrain = MultipeChoiceBrain();
  AudioPlayer audioPlayer = AudioPlayer();

  int timeLeft = 10;
  Timer? countdownTimer;

  void startTimer() {
    timeLeft = 10;
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timeLeft > 0) {
        await audioPlayer.play(AssetSource("sounds/tick.mp3"));
        setState(() {
          timeLeft--;
        });
      } else {
        if (multipeChoiceBrain.isFinished()) {
          handleFinishedQuiz();
        } else {
          setState(() {
            multipeChoiceBrain.nextQuestion();
            timeLeft = 10;
          });
        }
      }
    });
  }

  void handleUserAnswer(int index) {
    setState(() {
      selectedIndex = index;
      if (multipeChoiceBrain.getQuestionChoices()[index] ==
          multipeChoiceBrain.getQuestionAnswer())
        ++numberOfCorrect;
    });
    if (multipeChoiceBrain.isFinished()) {
      handleFinishedQuiz();
    } else {
      Future.delayed(
        Duration(seconds: 1),
        () => setState(() {
          timeLeft = 10;
          multipeChoiceBrain.nextQuestion();

          selectedIndex = null;
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
        title: "MCQ Quiz Finished",
        desc:
            "Your Score ${numberOfCorrect} / ${multipeChoiceBrain.numberOfQustion + 1}",
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
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              spacing: 50,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      "question ${multipeChoiceBrain.numberOfQustion + 1} of ${multipeChoiceBrain.mcqQuestions.length}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      multipeChoiceBrain.getQuestionText(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    shrinkWrap: true,
                    itemCount: multipeChoiceBrain.getQuestionChoices().length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (isSelected || selectedIndex != null)
                              ? () => {}
                              : () => handleUserAnswer(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? (multipeChoiceBrain
                                              .getQuestionChoices()[index]
                                              .toLowerCase() ==
                                          multipeChoiceBrain
                                              .getQuestionAnswer()
                                              .toLowerCase()
                                      ? Colors.green
                                      : Colors.red)
                                : Colors.white,
                            foregroundColor: isSelected
                                ? Colors.white
                                : widget.colors[0],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (isSelected) SizedBox(width: 2),
                                Text(
                                  multipeChoiceBrain
                                      .getQuestionChoices()[index],

                                  style: TextStyle(fontSize: 16),
                                ),
                                if (isSelected)
                                  Icon(
                                    multipeChoiceBrain
                                                .getQuestionChoices()[index] ==
                                            multipeChoiceBrain
                                                .getQuestionAnswer()
                                        ? Icons.check
                                        : Icons.close,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
