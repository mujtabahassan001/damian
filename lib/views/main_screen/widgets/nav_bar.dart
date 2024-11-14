import 'package:flutter/material.dart';

class NavBarMainScreen extends StatelessWidget {
  const NavBarMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey[800],
      child: const Column(
        children: [
          SizedBox(height: 100),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Projects', style: TextStyle(color: Colors.white,fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
