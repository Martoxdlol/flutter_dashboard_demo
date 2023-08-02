import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard_demo/card_see_all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double height = size.height - 140;

    if (height < 200) height = 200;

    return CardSeeAll(
      onSeeMore: () => showActiveUsers(context, key),
      child: InkWell(
        onTap: () => showActiveUsers(context, key),
        child: Container(
          width: 600,
          child: HeroedChart(
            height: height,
            chartKey: key,
          ),
        ),
      ),
    );
  }
}

class HeroedChart extends StatelessWidget {
  const HeroedChart({super.key, required this.chartKey, this.height});

  final Key chartKey;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: chartKey,
      child: DailyUsersChart(
        key: chartKey,
        height: height,
      ),
    );
  }
}

void showActiveUsers(BuildContext context, Key key) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        appBar: AppBar(
          title: Text("Active users"),
        ),
        body: Center(
          child: HeroedChart(
            chartKey: key,
          ),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  );
}

class DailyUsersChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DailyUsersChart({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  _DailyUsersChartState createState() => _DailyUsersChartState();
}

class _DailyUsersChartState extends State<DailyUsersChart> {
  List<UsersData> newInstalls = [
    UsersData('Jan', 110),
    UsersData('Feb', 141),
    UsersData('Mar', 188),
    UsersData('Apr', 273),
    UsersData('May', 212)
  ];
  List<UsersData> totalUsers = [
    UsersData('Jan', 12305),
    UsersData('Feb', 12457),
    UsersData('Mar', 12423),
    UsersData('Apr', 12501),
    UsersData('May', 12520)
  ];
  List<UsersData> uninstalls = [
    UsersData('Jan', 199),
    UsersData('Feb', 12457 + 110 - 12305),
    UsersData('Mar', 12423 + 141 - 12457),
    UsersData('Apr', 12501 + 188 - 12423),
    UsersData('May', 12520 + 273 - 12501)
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: widget.height,
        child:
            //Initialize the chart widget
            SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Monthly active users'),
          // Enable legend
          legend: Legend(isVisible: width > 420),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (data, point, series, pointIndex, seriesIndex) {
              final value = (data as UsersData).users.toInt();

              return Container(
                width: 70,
                height: 30,
                child: Center(
                  child: Text(
                    NumberFormat.compact().format(value),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
          series: <ChartSeries<UsersData, String>>[
            LineSeries<UsersData, String>(
              animationDuration: 0,
              dataSource: newInstalls,
              xValueMapper: (UsersData users, _) => users.month,
              yValueMapper: (UsersData users, _) => users.users,
              name: 'Installs',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
            LineSeries<UsersData, String>(
              animationDuration: 0,
              dataSource: totalUsers,
              xValueMapper: (UsersData users, _) => users.month,
              yValueMapper: (UsersData users, _) => users.users / 20,
              name: 'Total',
              xAxisName: "Month",
              markerSettings: MarkerSettings(isVisible: true, borderColor: Colors.brown),
              // Enable data label
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  return Text(
                    NumberFormat.compact().format((data as UsersData).users.toInt()),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            LineSeries<UsersData, String>(
              animationDuration: 0,
              dataSource: uninstalls,
              xValueMapper: (UsersData users, _) => users.month,
              yValueMapper: (UsersData users, _) => users.users,
              name: 'Uninstalls',
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  }
}

class UsersData {
  UsersData(this.month, this.users);

  final String month;
  final double users;
}
