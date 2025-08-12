import 'package:flutter/material.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/project_section.dart';
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
        primarySwatch: Colors.deepPurple,
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
  double _scrollOffset = 0.0;

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  final List<bool> _isHovering = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> navItems = ["Home", "About", "Projects", "Contact"];
    final List<GlobalKey> navKeys = [
      homeKey,
      aboutKey,
      projectsKey,
      contactKey
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 600;

    // Calculate AppBar background opacity based on scroll
    double opacity = (_scrollOffset / 150).clamp(0, 1);
    Color appBarColor = Colors.deepPurpleAccent.withOpacity(opacity);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: opacity > 0.1 ? 2 : 0,
        title: Text(
          "Pranav Amberkar",
          style: TextStyle(
            color: opacity > 0.5 ? Colors.black : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
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
                  color: _isHovering[index]
                      ? Colors.white
                      : (opacity > 0.5 ? Colors.black : Colors.black87),
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
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
              child: Text(
                'Navigation',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            for (int i = 0; i < navItems.length; i++)
              ListTile(
                title: Text(navItems[i]),
                onTap: () {
                  Navigator.pop(context);
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
              backgroundColor: Colors.white,
              maxWidth: 1200,
              content: HomeSection(
                onViewResume: () {
                  scrollToSection(contactKey);
                },
                onContactMe: () {
                  scrollToSection(contactKey);
                },
              ),
            ),
            const SizedBox(height: 15),
            Section(
              key: aboutKey,
              title: "About",
              backgroundColor: Colors.white,
              maxWidth: 1200,
              content: const AboutSection(),
            ),
            const SizedBox(height: 15),
            Section(
              key: projectsKey,
              title: "Projects",
              backgroundColor: Colors.white,
              maxWidth: 1200,
              content: const ProjectSection(),
            ),
            const SizedBox(height: 15),
            Section(
              key: contactKey,
              title: "Contact",
              backgroundColor: Colors.white,
              maxWidth: 1200,
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
  final double maxWidth;

  const Section({
    super.key,
    required this.title,
    required this.content,
    this.backgroundColor = Colors.white,
    this.maxWidth = 1200.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bool isSmallScreen = screenWidth < 600;

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 24),
      constraints: BoxConstraints(minHeight: (screenHeight * 0.9).toDouble()),
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth.toDouble()),
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
