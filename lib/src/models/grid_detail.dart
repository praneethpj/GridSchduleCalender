import 'package:flutter/material.dart';

class GridDetail {
  final double costPerGrid;
  final String lable;
  final Color arrowButtonColor;
  final int gridCount;

  GridDetail(
      {required this.lable,
      required this.costPerGrid,
      required this.arrowButtonColor,
      required this.gridCount});
}
