import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  NavBar({this.selectedIndex = 0, required this.onItemTapped});

  final List<String> items = ["Home", "About_Me", "Projects", "Contact"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(items.length, (index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                items[index],
                style: TextStyle(
                  color: isSelected ? Colors.brown : Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}