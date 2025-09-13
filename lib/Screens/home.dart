import 'package:flutter/material.dart';
import 'package:quiz_app/Screens/level_description.dart';
import 'package:quiz_app/Screens/mcq_quiz.dart';
import 'package:quiz_app/Screens/multipe_screen.dart';
import 'package:quiz_app/Screens/true_false_quiz.dart';
import 'package:quiz_app/helper/color_helper.dart';
import 'package:quiz_app/modules/level.dart';
import 'package:quiz_app/widgets/custom_outline_btn.dart';
import 'package:quiz_app/widgets/level_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Level> levels = [
      Level(
        title: "Level 1",
        subTitle: "True & False Quiz",
        icon: Icons.check,
        description: "This is some true false flutter questions",
        colors: [kL1, kL12],
        image: "book.png",
      ),
      Level(
        title: "Level 2",
        subTitle: "Multiple Choice Quiz",
        icon: Icons.play_arrow,
        description: "This is some Multiple Choice flutter questions",
        colors: [kL22, kBlueIcon],
        image: "ballons.png",
      ),
      Level(
        title: "Level 3",
        subTitle: "MCQ Quiz",
        icon: Icons.card_travel,
        description: "This is some MCQ flutter questions",
        colors: [kL32, kL1],
        image: "camera.png",
      ),
    ];

    List<Widget> pages = [
      TrueFalseQuiz(colors: levels[0].colors),
      MultipeScreen(colors: levels[1].colors),
      McqQuiz(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          CustomOutlineBtn(icon: Icons.favorite, size: 20),
          CustomOutlineBtn(icon: Icons.person_2, size: 25),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Start",
              style: TextStyle(
                fontSize: 32,
                color: kRedFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Be the first!",
              style: TextStyle(fontSize: 18, color: kGreyFont),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) => LevelWidget(
                  level: levels[index],
                  ontap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LevelDescription(
                        level: levels[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pages[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
