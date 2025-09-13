import 'package:flutter/material.dart';
import 'package:quiz_app/Screens/home.dart';
import 'package:quiz_app/helper/color_helper.dart';
import 'package:quiz_app/modules/multiple%20choice/multipe_choice_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class McqQuiz extends StatefulWidget {
  const McqQuiz({super.key});

  @override
  State<McqQuiz> createState() => _McqQuizState();
}

class _McqQuizState extends State<McqQuiz> {
  List<Icon> scoreKeeper = [];
  String selectedOption = '';
  MultipeChoiceBrain multipeChoiceBrain = MultipeChoiceBrain();

  void addUserScore(String selectedOption) {
    if (multipeChoiceBrain.isQuestionNotAnswered(selectedOption)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please answer the question")));
    } else {
      setState(() {
        multipeChoiceBrain.checkAnswer(selectedOption)
            ? scoreKeeper.add(Icon(Icons.check, color: Colors.green))
            : scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      });

      if (multipeChoiceBrain.isFinished()) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            // multipeChoiceBrain.reset();
            // Show Alert to User
            Alert(
              context: context,
              title: "MCQ Quiz Finished",
              desc: "good luck 😊",
              style: AlertStyle(backgroundColor: Colors.white),
              buttons: [
                DialogButton(
                  color: kBlueBg,
                  child: Text(
                    "Go to Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ).show();
            scoreKeeper.clear();
          });
        });
      } else {
        setState(() {
          selectedOption = '';
        });
        multipeChoiceBrain.nextQuestion();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Text
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  multipeChoiceBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Choices
            Expanded(
              flex: 3,
              child: ListView.builder(
                itemCount: multipeChoiceBrain.getQuestionChoices().length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    title: Text(multipeChoiceBrain.getQuestionChoices()[index]),
                    value: multipeChoiceBrain.getQuestionChoices()[index],
                    groupValue: selectedOption,
                    onChanged: (value) => setState(() {
                      selectedOption = value!;
                    }),
                  );
                },
              ),
            ),
            // Next Button
            ElevatedButton(
              onPressed: () => addUserScore(selectedOption),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                multipeChoiceBrain.isLastQueation() ? "Finish" : "Next",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: scoreKeeper),
            ),
          ],
        ),
      ),
    );
  }
}
