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
      padding: EdgeInsets.all(16),
      builder: (context) => Container(
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        constraints: BoxConstraints(maxHeight: 400, maxWidth: 600),
        child: Scaffold(
          appBar: AppBar(
            primary: false,
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
