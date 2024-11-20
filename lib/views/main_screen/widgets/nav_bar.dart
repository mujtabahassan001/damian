import 'package:flutter/material.dart';

class NavBarMainScreen extends StatelessWidget {
  const NavBarMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get the width of the screen
        double screenWidth = constraints.maxWidth;

        bool hideSidebar = screenWidth >= 1046 && screenWidth <= 1295;

        return Container(
          width: hideSidebar ? 0 : 250, 
          color: Colors.blueGrey[800],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text(
                  'Projects',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
