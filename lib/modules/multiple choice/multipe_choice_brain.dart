import 'package:quiz_app/modules/multiple%20choice/mcq_question.dart';

class MultipeChoiceBrain {
  int numberOfQustion = 0;
  List<McqQuestion> mcqQuestions = [
    McqQuestion(
      questionText:
          " Which programming language is used to build Flutter applications?",
      answer: "Dart",
      choices: ["Java", "Kotlin", "Dart"],
    ),
    McqQuestion(
      questionText: "Who developed the Flutter Framework?",
      answer: "Google",
      choices: ["Facebook", "Google", "Microsoft"],
    ),
    McqQuestion(
      questionText: "How many types of widgets are there in Flutter?",
      answer: "Two",
      choices: ["One", "Two", "Three"],
    ),
    McqQuestion(
      questionText:
          "Which of the following is used to manage the state of a StatefulWidget?",
      answer: "State",
      choices: ["BuildContext", "StatelessWidget", "State"],
    ),
  ];

  String getQuestionText() {
    return mcqQuestions[numberOfQustion].questionText;
  }

  String getQuestionAnswer() {
    return mcqQuestions[numberOfQustion].answer;
  }

  List<String> getQuestionChoices() {
    return mcqQuestions[numberOfQustion].choices;
  }

  void nextQuestion() {
    if (numberOfQustion == mcqQuestions.length - 1) {
      numberOfQustion = 0;
    } else {
      ++numberOfQustion;
    }
  }

  bool isFinished() {
    return numberOfQustion == mcqQuestions.length - 1;
  }

  bool checkAnswer(String userAnswer) {
    return getQuestionAnswer() == userAnswer;
  }

  bool isQuestionNotAnswered(String selectedOption) {
    return selectedOption.isEmpty;
  }

  void reset() {
    numberOfQustion = 0;
  }

  bool isLastQueation() {
    return numberOfQustion == mcqQuestions.length - 1;
  }
}
