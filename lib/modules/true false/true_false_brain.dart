import 'package:quiz_app/modules/true%20false/question.dart';

class TrueFalseBrain {
  int questionNumber = 0;
  List<Question> questions = [
    Question(
      quesText: "Flutter uses Dart as its programming language",
      answer: true,
    ),
    Question(quesText: "Everything in Flutter is a Widget", answer: true),
    Question(
      quesText: "Flutter only supports mobile application development",
      answer: false,
    ),
    Question(
      quesText:
          "Hot Reload and Hot Restart perform the same function in Flutter",
      answer: false,
    ),
    Question(
      quesText:
          "Stateless Widgets can change their internal state during runtime",
      answer: false,
    ),
  ];

  int getNumberOfQuestions() {
    return questions.length;
  }

  String getQuestionText() {
    return questions[questionNumber].quesText;
  }

  bool getQuestionAnswer() {
    return questions[questionNumber].answer;
  }

  void nextQuestion() {
    if (questionNumber == questions.length - 1) {
      questionNumber = 0;
    } else {
      ++questionNumber;
    }
  }

  bool checkAnswer(bool userAnswer) {
    return getQuestionAnswer() == userAnswer;
  }

  bool isFinished() {
    return questionNumber == questions.length - 1;
  }

  void reset() {
    questionNumber = 0;
  }
}
