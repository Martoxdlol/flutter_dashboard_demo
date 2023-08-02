import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/card_see_all.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardSeeAll(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            subtitle: Text("Change your settings"),
          ),
          ListTile(
            leading: Icon(Icons.person_rounded),
            title: Text("User profile"),
            subtitle: Text("Change your profile"),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("Calendar"),
            subtitle: Text("See your calendar"),
          ),
        ],
      ),
    );
  }
}
