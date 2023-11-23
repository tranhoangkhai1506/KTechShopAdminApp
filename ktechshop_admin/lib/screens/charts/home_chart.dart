import 'package:flutter/material.dart';
import 'package:ktechshopadmin/constants/dismension_constants.dart';
import 'package:ktechshopadmin/constants/routes.dart';
import 'package:ktechshopadmin/screens/charts/pie_chart.dart';

import 'column_chart_screen.dart';

class HomeChart extends StatefulWidget {
  const HomeChart({super.key});

  @override
  State<HomeChart> createState() => _HomeChartState();
}

class _HomeChartState extends State<HomeChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chart Home"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Column(children: [
                Center(
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/previews/001/187/079/original/chart-png.png",
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                ElevatedButton(
                    onPressed: () {
                      Routes.instance.push(
                        widget: Charts(),
                        context: context,
                      );
                    },
                    child: Text("According to Product")),
              ]),
              SizedBox(
                height: kDefaultPadding,
              ),
              Column(children: [
                Center(
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/167/167485.png",
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                ElevatedButton(
                    onPressed: () {
                      Routes.instance.push(
                        widget: OrderPieChart(),
                        context: context,
                      );
                    },
                    child: Text("According to Status")),
              ]),

              // Row(
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: Colors.grey.withOpacity(0.2),
              //             borderRadius: BorderRadius.circular(kDefaultPadding)),
              //         child: Column(
              //           children: [
              //             Text(
              //                 "View each type of product sold through a column chart"),
              //             ElevatedButton(
              //                 onPressed: () {
              //                   Routes.instance.push(
              //                     widget: Charts(),
              //                     context: context,
              //                   );
              //                 },
              //                 child: Text("According to Product")),
              //           ],
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: kDefaultPadding,
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: ElevatedButton(
              //           onPressed: () {
              //             Routes.instance.push(
              //               widget: OrderPieChart(),
              //               context: context,
              //             );
              //           },
              //           child: Text("According to Status")),
              //     ),
              //   ],
              // )
            ],
          ),
        ));
  }
}
