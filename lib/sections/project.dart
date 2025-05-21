import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool isEditing = false;
  TextEditingController _controller = TextEditingController();
  String projectText = "";

  @override
  void initState() {
    super.initState();
    loadProjectText();
  }

  void loadProjectText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      projectText = prefs.getString('project_text') ?? "These are my projects.";
      _controller.text = projectText;
    });
  }

  void saveProjectText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('project_text', _controller.text);
    setState(() {
      projectText = _controller.text;
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
                  "Projects",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isEditing) {
                    saveProjectText();
                  } else {
                    setState(() => isEditing = true);
                  }
                },
                child: Text(
                  isEditing ? "Save" : "Edit",
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
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
              : Text(
                  projectText,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
        ],
      ),
    );
  }
}