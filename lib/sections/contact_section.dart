import 'dart:math';
import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _message = "";

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

    const gradientStart = Color(0xFF7C4DFF);
    const gradientMid = Color(0xFF7B61FF);

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
                      "Get in Touch",
                      style: TextStyle(
                        fontSize: isSmall ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Contact info
                    Wrap(
                      spacing: 40,
                      runSpacing: 12,
                      children: [
                        _contactInfo(Icons.email, "pranavamberkar@example.com"),
                        _contactInfo(Icons.phone, "+91 9876543210"),
                        _contactInfo(Icons.location_on, "Mumbai, India"),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Contact form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: _inputDecoration("Your Name"),
                            onSaved: (val) => _name = val ?? "",
                            validator: (val) =>
                            val == null || val.isEmpty ? "Enter name" : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            decoration: _inputDecoration("Your Email"),
                            onSaved: (val) => _email = val ?? "",
                            validator: (val) =>
                            val == null || !val.contains("@")
                                ? "Enter valid email"
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            maxLines: 4,
                            decoration: _inputDecoration("Your Message"),
                            onSaved: (val) => _message = val ?? "",
                            validator: (val) =>
                            val == null || val.isEmpty
                                ? "Enter a message"
                                : null,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gradientStart,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // TODO: Send message logic
                              }
                            },
                            child: const Text(
                              "Send Message",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
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
  }

  Widget _contactInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2), width: 1.0.toDouble()),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.2), width: 1.0.toDouble()),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Colors.teal.withOpacity(0.6), width: 1.0.toDouble()),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
