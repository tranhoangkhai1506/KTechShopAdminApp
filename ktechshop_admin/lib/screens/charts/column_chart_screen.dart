import 'package:flutter/material.dart';
import 'package:ktechshopadmin/models/charts_model/charts_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'According to product',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            chart(context),
            Padding(
              padding: const EdgeInsets.only(left: 180, right: 150, top: 10),
            ),
            Divider(
              color: Colors.blue,
            ),
            SizedBox(
              height: 30,
            ),
            //circularChart(),
          ],
        ),
      ),
    );
  }
}

Widget chart(BuildContext context) {
  return FutureBuilder<List<ChartDataInfo>>(
    future: ChartDataInfo.createChart(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        List<ChartDataInfo> chartData = snapshot.data!;
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelRotation: 90, // Góc xoay của nhãn trục x
              labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            ),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries>[
              ColumnSeries<ChartDataInfo, String>(
                dataSource: chartData,
                pointColorMapper: (ChartDataInfo data, _) => data.color,
                xValueMapper: (ChartDataInfo data, _) => data.product,
                yValueMapper: (ChartDataInfo data, _) => data.quantity,
                enableTooltip: true,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  angle: 0,
                ),
              ),
            ],
            title: ChartTitle(
              text: 'Quantity of products sold',
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              alignment: ChartAlignment.center,
              textStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
          ),
        );
      }
    },
  );
}



// Widget Chart() {
//   return Container(
//       padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
//       child: SfCartesianChart(
//         primaryXAxis: CategoryAxis(
//           labelRotation: 0,
//           labelIntersectAction: AxisLabelIntersectAction.multipleRows,
//         ),
//         title: ChartTitle(
//             text: 'quantity products selled',
//             backgroundColor: Colors.white,
//             borderColor: Colors.black,
//             //  borderWidth: 1,
//             // Aligns the chart title to left
//             alignment: ChartAlignment.center,
//             textStyle: const TextStyle(
//               color: Colors.black,
//               fontFamily: 'Roboto',
//               fontStyle: FontStyle.normal,
//               fontSize: 20,
//             )),
//         series: <ChartSeries>[
//           ColumnSeries<ChartDataInfo, String>(
//             dataSource: createCha,
//             pointColorMapper: (ChartDataInfo data, _) => data.color,
//             xValueMapper: (ChartDataInfo data, _) => data.product,
//             yValueMapper: (ChartDataInfo data, _) => data.quantity,
//             enableTooltip: true,
//             dataLabelSettings: DataLabelSettings(
//               isVisible: true,
//               angle: 0,
//             ),
//           ),
//         ],
//       ));
// }
