import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatefulWidget {
  final VoidCallback onViewResume;
  final VoidCallback onContactMe;

  const HomeSection({
    super.key,
    required this.onViewResume,
    required this.onContactMe,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceCtrl;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // start entrance animation
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
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
                  color.withValues(alpha: 0.5),
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

  Widget _statTile(String label, int endValue, Duration duration) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: endValue),
      duration: duration,
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final isSmall = screenW < 800;

    // entrance animation tweens
    final fade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.1, 0.9, curve: Curves.easeOut),
    );
    final slide = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutExpo),
    );

    // decorative colors inspired by your reference (purples + soft lavenders)
    const gradientStart = Color(0xFF7C4DFF);
    const gradientMid = Color(0xFF7B61FF);
    const gradientEnd = Color(0xFFEDE7FF);

    return LayoutBuilder(builder: (context, constraints) {
      // ensure maxWidth is a double (avoid num -> double errors)
      final double maxWidth =
      (constraints.maxWidth < 1200 ? constraints.maxWidth : 1100)
          .toDouble();

      return Container(
        // gentle background gradient like the reference
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientEnd, gradientMid.withValues(alpha: 0.05)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              // decorative floating blobs (animated rotation & fade)
              AnimatedBuilder(
                animation: _entranceCtrl,
                builder: (context, child) {
                  return IgnorePointer(
                    child: SizedBox(
                      height: isSmall ? 520 : 420,
                      child: Stack(
                        children: [
                          _buildBlob(
                            size: isSmall ? 220.0 : 320.0,
                            alignment: const Alignment(-0.9, -0.8),
                            color: gradientStart,
                            rotateDeg: 12.0,
                            anim: fade,
                            opacity: 0.16,
                          ),
                          _buildBlob(
                            size: isSmall ? 160.0 : 260.0,
                            alignment: const Alignment(0.9, -0.7),
                            color: gradientMid,
                            rotateDeg: -20.0,
                            anim: fade,
                            opacity: 0.12,
                          ),
                          _buildBlob(
                            size: isSmall ? 300.0 : 420.0,
                            alignment: const Alignment(0.6, 0.6),
                            color: Colors.purpleAccent,
                            rotateDeg: 6.0,
                            anim: fade,
                            opacity: 0.08,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // main content
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 18.0 : 48.0,
                    vertical: isSmall ? 18.0 : 36.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),

                      // hero row: left = intro, right = profile card
                      AnimatedBuilder(
                        animation: slide,
                        builder: (context, _) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left: Text area
                              Expanded(
                                flex: isSmall ? 10 : 6,
                                child: Transform.translate(
                                  offset: Offset(0, (1 - slide.value) * 20.0),
                                  child: Opacity(
                                    opacity: slide.value.toDouble(),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // subtle badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0, horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            color:
                                            gradientStart.withValues(alpha: 0.12),
                                            borderRadius:
                                            BorderRadius.circular(20.0),
                                          ),
                                          child: const Text(
                                            "Flutter • Android • Web",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF4A148C),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        Text(
                                          "Hi, I'm",
                                          style: TextStyle(
                                            fontSize: isSmall ? 18.0 : 20.0,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Pranav Amberkar",
                                          style: TextStyle(
                                            fontSize: isSmall ? 28.0 : 44.0,
                                            fontWeight: FontWeight.w900,
                                            color: gradientStart,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        AnimatedTextKit(
                                          repeatForever: true,
                                          pause: const Duration(milliseconds: 1200),
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              "Flutter Developer",
                                              textStyle: TextStyle(
                                                fontSize: isSmall ? 16.0 : 20.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              speed: const Duration(milliseconds: 70),
                                            ),
                                            TypewriterAnimatedText(
                                              "BSc IT Graduate",
                                              textStyle: TextStyle(
                                                fontSize: isSmall ? 16.0 : 20.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              speed: const Duration(milliseconds: 70),
                                            ),
                                            TypewriterAnimatedText(
                                              "Firebase · REST · UI/UX",
                                              textStyle: TextStyle(
                                                fontSize: isSmall ? 16.0 : 20.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              speed: const Duration(milliseconds: 70),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 18),
                                        Text(
                                          "I build beautiful, performant apps for mobile & web. "
                                              "My work emphasizes clean architecture, friendly UX, and reliable backend integration.",
                                          style: TextStyle(
                                            fontSize: isSmall ? 14.0 : 16.0,
                                            height: 1.5,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        // CTA Buttons
                                        Wrap(
                                          spacing: 12.0,
                                          runSpacing: 8.0,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: widget.onViewResume,
                                              icon: const Icon(Icons.download_rounded),
                                              label: const Text("Download CV"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: gradientStart,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 14.0, horizontal: 18.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(12.0),
                                                ),
                                                elevation: 6.0,
                                              ),
                                            ),
                                            OutlinedButton.icon(
                                              onPressed: widget.onContactMe,
                                              icon: const Icon(Icons.send),
                                              label: const Text("Get in touch"),
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color:
                                                    gradientStart.withValues(alpha: 0.9)),
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 14.0, horizontal: 18.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(12.0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 28),

                                        // stats strip (small chips)
                                        Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: gradientMid.withValues(alpha: 0.95),
                                            borderRadius: BorderRadius.circular(14.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.08),
                                                blurRadius: 12.0,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              _statTile("Projects", 12, const Duration(seconds: 2)),
                                              const SizedBox(width: 24.0),
                                              _statTile("Clients", 6, const Duration(seconds: 2)),
                                              const SizedBox(width: 24.0),
                                              _statTile("Awards", 2, const Duration(seconds: 2)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 26.0),

                              // Right: Profile card with image cutout, subtle card & patterns
                              if (!isSmall)
                                Expanded(
                                  flex: 4,
                                  child: Transform.scale(
                                    scale: (0.98 + 0.02 * slide.value).toDouble(),
                                    child: Opacity(
                                      opacity: slide.value.toDouble(),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Card background
                                            Container(
                                              width: 320.0,
                                              height: 320.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    gradientStart.withValues(alpha: 0.95),
                                                    gradientMid.withValues(alpha: 0.9),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius: BorderRadius.circular(28.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withValues(alpha: 0.14),
                                                    offset: const Offset(0, 8),
                                                    blurRadius: 24.0,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // decorative dot pattern
                                            const Positioned(
                                              left: 18.0,
                                              top: 18.0,
                                              child: Opacity(
                                                opacity: 0.12,
                                                child: Icon(
                                                  Icons.grid_view_rounded,
                                                  size: 28.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),

                                            // profile circle (cutout) with border & white ring
                                            Positioned(
                                              right: 20.0,
                                              top: 18.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white.withValues(alpha: 0.9),
                                                    width: 6.0,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withValues(alpha: 0.18),
                                                      blurRadius: 18.0,
                                                      offset: const Offset(0, 8),
                                                    ),
                                                  ],
                                                ),
                                                child: const CircleAvatar(
                                                  radius: 70.0,
                                                  backgroundImage: AssetImage('assets/profile.jpg'),
                                                ),
                                              ),
                                            ),

                                            // bottom content area
                                            Positioned(
                                              left: 18.0,
                                              bottom: 18.0,
                                              right: 18.0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "UI / Flutter Designer",
                                                    style: TextStyle(
                                                      color: Colors.white.withValues(alpha: 0.85),
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6.0),
                                                  const Text(
                                                    "Passionate about shipping delightful experiences and clean code.",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12.0),
                                                  Row(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: Colors.white,
                                                          foregroundColor: gradientStart,
                                                          padding: const EdgeInsets.symmetric(
                                                              vertical: 10.0, horizontal: 12.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8.0)),
                                                        ),
                                                        child: const Text("Portfolio"),
                                                      ),
                                                      const SizedBox(width: 10.0),
                                                      OutlinedButton(
                                                        onPressed: () {},
                                                        style: OutlinedButton.styleFrom(
                                                          side: BorderSide(
                                                              color: Colors.white.withValues(alpha: 0.6)),
                                                          foregroundColor: Colors.white,
                                                          padding: const EdgeInsets.symmetric(
                                                              vertical: 10.0, horizontal: 12.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8.0)),
                                                        ),
                                                        child: const Text("Contact"),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 36.0),

                      // On small screens show profile card in stacked mobile layout
                      if (isSmall)
                        FadeTransition(
                          opacity: fade,
                          child: Center(
                            child: Container(
                              width: 280.0,
                              padding: const EdgeInsets.all(18.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 18.0,
                                    offset: const Offset(0, 8),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 58.0,
                                    backgroundImage:
                                    AssetImage('assets/profile.jpg'),
                                  ),
                                  const SizedBox(height: 12.0),
                                  const Text(
                                    "Pranav Amberkar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  const Text(
                                    "Flutter Developer · BSc IT",
                                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: widget.onViewResume,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: gradientStart,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: const Text("Resume"),
                                      ),
                                      const SizedBox(width: 8.0),
                                      OutlinedButton(
                                        onPressed: widget.onContactMe,
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)),
                                        ),
                                        child: const Text("Contact"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 36.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
