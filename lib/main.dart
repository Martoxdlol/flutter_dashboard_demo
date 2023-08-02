import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/appbar.dart';
import 'package:flutter_dashboard_demo/calendar.dart';
import 'package:flutter_dashboard_demo/charts.dart';
import 'package:flutter_dashboard_demo/drawer.dart';
import 'package:flutter_dashboard_demo/form.dart';
import 'package:flutter_dashboard_demo/optionas_card.dart';
import 'package:flutter_dashboard_demo/reviews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    int count = (size.width + 100) ~/ 500;
    if (count < 1) count = 1;

    final childWidth = (size.width - 32 - 16 * (count - 1)) / count;
    final childHeight = 320;
    final aspectRation = childWidth / childHeight;

    return Scaffold(
      appBar: MainAppBar(),
      drawer: MainDrawer(),
      body: GridView.count(
        padding: EdgeInsets.all(16),
        crossAxisCount: count,
        childAspectRatio: aspectRation,
        children: [
          MyChart(),
          ReviewsCard(),
          OptionsCard(),
          CalendarCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showFormPage(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
