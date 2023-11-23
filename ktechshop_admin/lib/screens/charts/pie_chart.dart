import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';

class OrderPieChart extends StatefulWidget {
  const OrderPieChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrderPieChartState createState() => _OrderPieChartState();
}

class _OrderPieChartState extends State<OrderPieChart> {
  Map<String, int> statusCount = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot orders =
        await FirebaseFirestore.instance.collection('orders').get();

    setState(() {
      statusCount = countStatus(orders.docs);
    });
  }

  Map<String, int> countStatus(List<QueryDocumentSnapshot> orders) {
    Map<String, int> statusCount = {};

    orders.forEach((order) {
      String status = order['status'];
      statusCount[status] =
          statusCount.containsKey(status) ? statusCount[status]! + 1 : 1;
    });

    return statusCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('According to Status'),
      ),
      body: Center(
        child: statusCount.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: true,
                    ),
                    centerSpaceRadius:
                        40, // Điều chỉnh kích thước không gian trống ở giữa biểu đồ
                    sections: getStatusSections(),
                    sectionsSpace: 0,
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  List<PieChartSectionData> getStatusSections() {
    return statusCount.entries
        .map((entry) => PieChartSectionData(
              color: getColor(entry.key),
              value: entry.value.toDouble(),
              title: '${entry.key}\n${entry.value}',
              radius: 100,
              titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
        .toList();
  }

  Color getColor(String status) {
    // You can customize colors based on the status
    if (status == 'Pending') {
      return Colors.yellow;
    } else if (status == 'Delivery') {
      return Colors.blue;
    } else if (status == 'Completed') {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }
}
