import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  void _downloadResume() {
    html.window.open(
      'assets/Pranav_Amberkar_Resume.pdf', // Place your resume PDF in assets
      '_blank',
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildListItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF9FAFB), Color(0xFFEFF6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "Resume",
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _downloadResume,
            icon: const Icon(Icons.download_rounded),
            label: const Text("Download PDF"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
          const SizedBox(height: 40),

          // Two Column Layout
          isSmallScreen
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildResumeContent(),
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildLeftColumn(),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRightColumn(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLeftColumn() {
    return [
      _buildSectionTitle("Education"),
      const SizedBox(height: 10),
      _buildListItem(
        "BSc Information Technology - Mumbai University (Sathaye College)",
        "2021 - 2025",
      ),
      _buildListItem(
        "HSC - Sathaye College",
        "2020 - 2021 | 69.67%",
      ),
      _buildListItem(
        "SSC - Paranjape Vidyalaya",
        "2018 - 2019 | 72.80%",
      ),
      const SizedBox(height: 20),
      _buildSectionTitle("Skills"),
      const SizedBox(height: 10),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _skillChip("Flutter"),
          _skillChip("Dart"),
          _skillChip("Android (Java/Kotlin)"),
          _skillChip("Firebase"),
          _skillChip("REST APIs"),
          _skillChip("UI/UX Design"),
          _skillChip("Git & GitHub"),
          _skillChip("Python"),
        ],
      ),
    ];
  }

  List<Widget> _buildRightColumn() {
    return [
      _buildSectionTitle("Work Experience"),
      const SizedBox(height: 10),
      _buildListItem(
        "Intern - Betinal Pvt. Ltd.",
        "Dec 2022 – June 2023\n• Facilitated client engagement & streamlined communications.\n• Managed Cynotics App backend processes.",
      ),
      const SizedBox(height: 20),
      _buildSectionTitle("Projects"),
      const SizedBox(height: 10),
      _buildListItem(
        "Nikhil Private Classes Management System",
        "Comprehensive Flutter & Firebase app for managing attendance, fees, test performance, and more.",
      ),
    ];
  }

  List<Widget> _buildResumeContent() {
    return [
      ..._buildLeftColumn(),
      const SizedBox(height: 30),
      ..._buildRightColumn(),
    ];
  }

  Widget _skillChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
