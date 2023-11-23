import 'package:flutter/material.dart';
import 'package:ktechshopadmin/models/charts_model/chart_items_model.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ChartDataInfo {
  ChartDataInfo(this.product, this.quantity, [this.color]);

  final String product;
  final int quantity;
  final Color? color;

  static Future<List<ChartDataInfo>> createChart(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    List<ChartItems> _chartItemList =
        await appProvider.getAllOrderCompletedToChart();

    // Danh sách màu để sử dụng cho mỗi ChartDataInfo
    List<Color> colors = [
      Color.fromRGBO(9, 0, 136, 1),
      Color.fromRGBO(147, 0, 119, 1),
      Color.fromRGBO(228, 0, 124, 1),
      Color.fromARGB(255, 59, 19, 41),
      Color.fromARGB(255, 223, 215, 67),
      Color.fromARGB(255, 7, 170, 118),
      Color.fromARGB(255, 170, 7, 83),
      Color.fromARGB(255, 7, 170, 42)
    ];

    // Sử dụng danh sách màu khi tạo ChartDataInfo
    return _chartItemList.asMap().entries.map((entry) {
      int index = entry.key;
      ChartItems element = entry.value;
      Color color = colors[
          index % colors.length]; // Chọn màu theo thứ tự từ danh sách màu

      return ChartDataInfo(
        element.productName,
        element.quantity,
        color,
      );
    }).toList();
  }
}


// final List<ChartDataInfo> indexChart = [
//   ChartDataInfo("Mobile", 25, Color.fromRGBO(9, 0, 136, 1)),
//   ChartDataInfo("Laptop", 38, Color.fromRGBO(147, 0, 119, 1)),
//   ChartDataInfo("ipad", 34, Color.fromRGBO(228, 0, 124, 1)),
//   ChartDataInfo("keyboard", 52, Color.fromARGB(255, 59, 19, 41)),
//   ChartDataInfo("Mouse", 52, Color.fromARGB(255, 223, 215, 67)),
//   ChartDataInfo("Headphone", 12, Color.fromARGB(255, 7, 170, 118)),
// ];
