import 'package:flutter/material.dart';

class Schedule {
  int day;
  String time;
  int availability;
  Color timeAvailableColor;
  Color timeUnavailableColor;
  Color timeAvailableTextColor;
  Color timeUnavailableTextColor;
  double? timeAvailableTextSize=12;
  double? timeUnavailableTextSize=12;


  Function(Object) onTapTimeAvailable;
  Function(Object) onTapTimeUnavailable;

  Schedule(
      {required this.day,
      required this.time,
      required this.availability,
      required this.timeAvailableColor,
      required this.timeUnavailableColor,
      required this.timeAvailableTextColor,
      required this.timeUnavailableTextColor,
      required this.onTapTimeAvailable,
      required this.onTapTimeUnavailable,this.timeAvailableTextSize,this.timeUnavailableTextSize});
}
