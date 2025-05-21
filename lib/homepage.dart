import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'navbarr.dart';
import 'sections/aboutme.dart';
import 'sections/project.dart';
import 'sections/contact.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const Center(
      child: Text(
        'This is my portfolio',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.red, // Added color here
        ),
      ),
    ),
    AboutMe(),
    Projects(),
    Contact(),
  ];

  void onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.link),
              title: Text('Copy Portfolio Link'),
              onTap: () {
                Navigator.pop(context);
                _copyLink();
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share via App'),
              onTap: () {
                Navigator.pop(context);
                _shareViaApp();
              },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                _exportAsPdf();
              },
            ),
          ],
        );
      },
    );
  }

  void _copyLink() {
    Clipboard.setData(ClipboardData(text: "https://myportfolio.example.com"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Link copied to clipboard')),
    );
  }

  void _shareViaApp() {
    Share.share("Check out my portfolio! https://myportfolio.example.com");
  }

  void _exportAsPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Text(
              "My Portfolio\n\nAbout Me:\n[Add your About Me content here]\n\nProjects:\n[Add Projects here]\n\nContact:\n[Add Contact here]",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          NavBar(
            selectedIndex: selectedIndex,
            onItemTapped: onNavItemTapped,
          ),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showShareOptions,
        tooltip: 'Share Portfolio',
        child: Icon(Icons.share),
      ),
    );
  }
}
