import 'package:flutter/material.dart';
import 'package:quiz_app/modules/level.dart';
import 'package:quiz_app/widgets/custom_outline_btn.dart';

class LevelDescription extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;
  const LevelDescription({super.key, required this.level, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: level.colors),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomOutlineBtn(
                icon: Icons.close,
                size: 24,
                iconColor: Colors.white,
                ontap: () => Navigator.pop(context),
              ),
            ),
            Image.asset(
              "assets/images/${level.image}",
              width: 180,
              height: 180,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(level.title, style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                Text(
                  level.subTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(level.description, style: TextStyle(color: Colors.white)),
              ],
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Game", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
