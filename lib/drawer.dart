import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/charts.dart';

final drawerKey = GlobalKey<_MainDrawerState>();

class MainDrawer extends StatefulWidget {
  MainDrawer() : super(key: drawerKey);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: position,
      onDestinationSelected: (value) {
        if (value == 1) {
          showActiveUsers(context, UniqueKey());
        }
      },
      children: [
        DrawerTitle(
          title: Text("Pages"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text("Home"),
        ),
        DrawerTitle(
          title: Text("Data"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.people_rounded),
          label: Text("Active users"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.download_rounded),
          label: Text("Downloads"),
        ),
      ],
    );
  }
}

class DrawerTitle extends StatelessWidget {
  const DrawerTitle({
    super.key,
    required this.title,
  });

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleSmall!,
        child: title,
      ),
    );
  }
}
