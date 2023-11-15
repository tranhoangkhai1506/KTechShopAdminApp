import 'package:flutter/material.dart';
import 'package:ktechshopadmin/provider/app_provider.dart';
import 'package:provider/provider.dart';

class ChartDataInfo {
  ChartDataInfo(this.product, this.quantity, [this.color]);
  
  final String product;
  final int quantity;
  final Color? color;
}




final List<ChartDataInfo> indexChart = [
  ChartDataInfo("Mobile", 25, Color.fromRGBO(9, 0, 136, 1)),
  ChartDataInfo("Laptop", 38, Color.fromRGBO(147, 0, 119, 1)),
  ChartDataInfo("ipad", 34, Color.fromRGBO(228, 0, 124, 1)),
  ChartDataInfo("keyboard", 52, Color.fromARGB(255, 59, 19, 41)),
  ChartDataInfo("Mouse", 52, Color.fromARGB(255, 223, 215, 67)),
  ChartDataInfo("Headphone", 12, Color.fromARGB(255, 7, 170, 118)),
];
