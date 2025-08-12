import 'dart:math';
import 'package:flutter/material.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  final projects = [
    {
      "title": "Nikhil Private Classes Management System",
      "description":
      "A complete class management system built with Flutter, Firebase Authentication, and Firestore. Features attendance tracking, performance analytics, and fee reminders.",
      "tech": ["Flutter", "Firebase Auth", "Firestore"],
      "link": "https://github.com/yourusername/nikhil-private-classes"
    },
    {
      "title": "Call Logger App",
      "description":
      "An Android app built with Kotlin and Room DB to log calls, gather feedback, and generate call reports.",
      "tech": ["Kotlin", "Room DB"],
      "link": "https://github.com/yourusername/call-logger-app"
    },
    {
      "title": "Task Management App",
      "description":
      "A cross-platform task management application using Flutter, Sqflite for offline storage, and Firebase Authentication for secure sign-in.",
      "tech": ["Flutter", "Sqflite", "Firebase Auth"],
      "link": "https://github.com/yourusername/task-management-app"
    },
  ];

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
                  color.withOpacity(0.95),
                  color.withOpacity(0.5)
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

  Widget _buildProjectCard(Map<String, dynamic> project, bool isSmall) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: Colors.deepPurple.withOpacity(0.15),
            width: 1.2,
          ),
        ),
        constraints: BoxConstraints(
          maxWidth: isSmall ? double.infinity : 320.toDouble(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project["title"]!,
              style: TextStyle(
                fontSize: isSmall ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project["description"]!,
              style: TextStyle(
                fontSize: isSmall ? 14 : 15,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: (project["tech"] as List<String>)
                  .map((t) => Chip(
                label: Text(t),
                backgroundColor:
                Colors.deepPurple.withOpacity(0.08),
                labelStyle: const TextStyle(fontSize: 12),
              ))
                  .toList(),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // open GitHub link
                },
                child: const Text(
                  "View Project",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 900;

    final fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.1, 0.9, curve: Curves.easeOut),
    );
    final slide = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutExpo),
    );

    final gradientStart = const Color(0xFF7C4DFF);
    final gradientMid = const Color(0xFF7B61FF);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, gradientMid.withOpacity(0.03)],
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
                  height: isSmall ? 800 : 600,
                  child: Stack(
                    children: [
                      _buildBlob(
                        size: isSmall ? 200 : 280,
                        alignment: const Alignment(-0.9, -0.8),
                        color: gradientStart,
                        rotateDeg: 15,
                        anim: fade,
                        opacity: 0.15,
                      ),
                      _buildBlob(
                        size: isSmall ? 140 : 220,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Projects",
                      style: TextStyle(
                        fontSize: isSmall ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.start,
                      children: projects
                          .map((p) => _buildProjectCard(p, isSmall))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
