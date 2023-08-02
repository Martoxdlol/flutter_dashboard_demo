import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/transparent_page_route.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Dashboard"),
      actions: [
        IconButton(
          onPressed: () {
            showProfileInfo(context);
          },
          icon: CircleAvatar(
            child: Text("TC"),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

void showProfileInfo(BuildContext context) {
  Navigator.of(context).push(
    TransparentPageRoute(
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: 400, maxWidth: 600),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Center(
            child: Text("Profile"),
          ),
        ),
      ),
    ),
  );
}
