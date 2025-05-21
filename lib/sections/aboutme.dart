import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutMe extends StatefulWidget {
  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  bool isEditing = false;
  String aboutText = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAboutText();
  }

  Future<void> _loadAboutText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aboutText = prefs.getString('about_text') ??
          "I'm a passionate flutter app developer.";
      _controller.text = aboutText;
    });
  }

  Future<void> _saveAboutText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('about_text', _controller.text);
    setState(() {
      aboutText = _controller.text;
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "About Me",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isEditing) {
                    _saveAboutText();
                  } else {
                    setState(() {
                      isEditing = true;
                      _controller.text = aboutText;
                    });
                  }
                },
                child: Text(
                  isEditing ? 'Save' : 'Edit',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          isEditing
              ? TextField(
                  controller: _controller,
                  maxLines: null,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'About Yourself',
                  ),
                )
              : Text(
                  aboutText,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
        ],
      ),
    );
  }
}