import 'package:flutter/material.dart';
import 'package:quiz_app/modules/level.dart';

class LevelWidget extends StatelessWidget {
  final Level level;
  final VoidCallback ontap;
  const LevelWidget({super.key, required this.level, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 50),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: level.colors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      padding: EdgeInsets.all(10),
                      side: BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Icon(level.icon),
                  ),
                  SizedBox(height: 12),
                  Text(level.title, style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Text(
                    level.subTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -60,
              right: 20,
              child: Image.asset(
                "assets/images/${level.image}",
                width: 170,
                height: 170,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
