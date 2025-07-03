import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              CircleAvatar(
                radius: screenWidth < 600 ? 50 : 70,
                backgroundImage: const AssetImage('assets/profile.jpg'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hi, I'm",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const Text(
                    "Pranav Amberkar",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Flutter Developer",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        "BSc IT Graduate",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "About Me",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "I'm a passionate Flutter developer with a background in Information Technology. "
            "I love building beautiful, responsive, and high-performance mobile apps. "
            "With experience in Firebase, Dart, and UI/UX design, I aim to create apps that not only work well but also look great. "
            "I'm always learning and exploring new technologies to grow as a developer.",
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }
}
