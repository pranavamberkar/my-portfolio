import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Hi, I'm Pranav Amberkar!",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Text(
          "BSc IT Graduate | Flutter Developer",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
