import 'package:flutter/material.dart';
import 'package:ktechshopadmin/models/charts_model/charts_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatefulWidget {
  @override
  State<Charts> createState() => _ChartsState();
}



class _ChartsState extends State<Charts> {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ColumnSeriesChart',
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Chart(),
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
    );
  }
}

Widget Chart() {
  return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          labelRotation: 0,
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        ),
        title: ChartTitle(
            text: 'quantity products selled',
            backgroundColor: Colors.white,
            borderColor: Colors.black,
            //  borderWidth: 1,
            // Aligns the chart title to left
            alignment: ChartAlignment.center,
            textStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal,
              fontSize: 20,
            )),
        series: <ChartSeries>[
          ColumnSeries<ChartDataInfo, String>(
            dataSource: indexChart,
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
      ));
}
