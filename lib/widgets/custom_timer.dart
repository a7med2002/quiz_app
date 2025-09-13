import 'package:flutter/material.dart';

class CustomTimer extends StatelessWidget {
  final int timeLeft;
  const CustomTimer({super.key, required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: timeLeft / 10,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          Text(
            timeLeft.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
