import 'dart:math';
import 'package:flutter/material.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _buildBlob({
    required double size,
    required Alignment alignment,
    required Color color,
    required double rotateDeg,
    required Animation<double> anim,
    double opacity = 0.15,
  }) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: rotateDeg * pi / 180 * anim.value,
        child: Opacity(
          opacity: opacity * anim.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  color.withValues(alpha: 0.95),
                  color.withValues(alpha: 0.5)
                ],
                center: const Alignment(-0.2, -0.8),
              ),
              borderRadius: BorderRadius.circular(size * 0.45),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 800;

    final fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.1, 0.9, curve: Curves.easeOut),
    );
    final slide = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutExpo),
    );

    const gradientStart = Color(0xFF7C4DFF);
    const gradientMid = Color(0xFF7B61FF);

    final skills = [
      "Flutter",
      "Dart",
      "Firebase",
      "Kotlin",
      "Java",
      "REST APIs",
      "Git & GitHub",
      "UI/UX Design"
    ];

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, gradientMid.withValues(alpha: 0.03)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Background blobs
            AnimatedBuilder(
              animation: _ctrl,
              builder: (context, child) {
                return IgnorePointer(
                  child: SizedBox(
                    height: isSmall ? 600 : 420,
                    child: Stack(
                      children: [
                        _buildBlob(
                          size: isSmall ? 200 : 300,
                          alignment: const Alignment(-0.9, -0.8),
                          color: gradientStart,
                          rotateDeg: 15,
                          anim: fade,
                          opacity: 0.15,
                        ),
                        _buildBlob(
                          size: isSmall ? 140 : 240,
                          alignment: const Alignment(0.9, -0.7),
                          color: gradientMid,
                          rotateDeg: -18,
                          anim: fade,
                          opacity: 0.12,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 18 : 48,
                vertical: isSmall ? 18 : 36,
              ),
              child: FadeTransition(
                opacity: fade,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(slide),
                  child: isSmall
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextContent(skills, isSmall),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _buildTextContent(skills, isSmall),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/about_me.jpg',
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTextContent(List<String> skills, bool isSmall) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Me",
          style: TextStyle(
            fontSize: isSmall ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Hello! I'm Pranav Amberkar, a passionate Flutter & Android developer "
              "with a BSc in Information Technology. I enjoy creating modern, user-friendly "
              "mobile and web applications, and I’m always eager to learn and explore "
              "new technologies. My focus is on delivering clean, efficient, and scalable "
              "code that solves real-world problems.",
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            height: 1.5,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Skills",
          style: TextStyle(
            fontSize: isSmall ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map(
                (skill) => Chip(
              label: Text(skill),
              backgroundColor: Colors.deepPurple.withValues(alpha: 0.08),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
