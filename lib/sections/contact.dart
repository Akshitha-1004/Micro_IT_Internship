import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool isEditing = false;
  TextEditingController _controller = TextEditingController();
  String contactText = "";

  @override
  void initState() {
    super.initState();
    loadContactText();
  }

  void loadContactText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contactText = prefs.getString('contact_text') ?? "Email: example@email.com\nPhone: 9876543201";
      _controller.text = contactText;
    });
  }

  void saveContactText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('contact_text', _controller.text);
    setState(() {
      contactText = _controller.text;
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
                  "Contact",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.brown),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isEditing) {
                    saveContactText();
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
                  style: TextStyle(color: Colors.brown),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
              : Text(
                  contactText,
                  style: TextStyle(fontSize: 18, color: Colors.brown),
                ),
        ],
      ),
    );
  }
}