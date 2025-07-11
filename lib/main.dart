import 'package:flutter/material.dart';
import 'sections/home_section.dart';
import 'sections/project_section.dart';
import 'sections/resume_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pranav Amberkar Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      debugShowCheckedModeBanner: false,
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();
  final projectsKey = GlobalKey();
  final resumeKey = GlobalKey();
  final contactKey = GlobalKey();

  final List<bool> _isHovering = [false, false, false, false];

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> navItems = ["Home", "Projects", "Resume", "Contact"];
    final List<GlobalKey> navKeys = [
      homeKey,
      projectsKey,
      resumeKey,
      contactKey
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Pranav Amberkar",
          style: TextStyle(color: Colors.black),
        ),
        actions: isSmallScreen
            ? null
            : List.generate(navItems.length, (index) {
                return MouseRegion(
                  onEnter: (_) => setState(() => _isHovering[index] = true),
                  onExit: (_) => setState(() => _isHovering[index] = false),
                  child: TextButton(
                    onPressed: () => scrollToSection(navKeys[index]),
                    child: Text(
                      navItems[index],
                      style: TextStyle(
                        color: _isHovering[index] ? Colors.white : Colors.black,
                        fontWeight: _isHovering[index]
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
      ),
      drawer: isSmallScreen
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.lightBlue),
                    child: Text(
                      'Navigation',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  for (int i = 0; i < navItems.length; i++)
                    ListTile(
                      title: Text(navItems[i]),
                      onTap: () {
                        Navigator.pop(context); // Close drawer
                        scrollToSection(navKeys[i]);
                      },
                    ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Section(
              key: homeKey,
              title: "Home",
              backgroundColor: Colors.lightGreen,
              content: const HomeSection(),
            ),
            const SizedBox(height: 15),
            Section(
              key: projectsKey,
              title: "Projects",
              backgroundColor: Colors.lightGreenAccent,
              content: const ProjectSection(),
            ),
            const SizedBox(height: 15),
            Section(
              key: resumeKey,
              title: "Resume",
              backgroundColor: Colors.lime,
              content: const ResumeSection(),
            ),
            const SizedBox(height: 15),
            Section(
              key: contactKey,
              title: "Contact",
              backgroundColor: Colors.limeAccent,
              content: const ContactSection(),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final Widget content;
  final Color backgroundColor;

  const Section({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenWidth < 600;

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 24),
      constraints: BoxConstraints(minHeight: screenHeight * 0.9),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 24 : 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
