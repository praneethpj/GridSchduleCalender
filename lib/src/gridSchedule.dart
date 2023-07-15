

import 'package:flutter/material.dart';
import 'package:gridschedule/src/blocs/grids/grid_bloc.dart';
import 'package:gridschedule/src/models/grid_detail.dart';
import 'package:gridschedule/src/models/schedule_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gridschedule/src/repositories/grid_repositoy.dart';

class GridSchedule extends StatefulWidget{
  final int profileId;
  final double costperhour;
  final String profileName;
  final String profileType;
  final String title;

  const GridSchedule(
      {super.key,
        required this.profileId,
        required this.costperhour,
        required this.profileName,
        required this.profileType,
        required this.title});
  @override
  State<GridSchedule> createState() => _GridScheduleState();

}

class _GridScheduleState extends State<GridSchedule> {
  String currentDay = "";
  String currentMonth = "";
  String currentYear = "";
  int currentMonthNum = 0;
  bool isToday = true;
  int dayId = 0;

  String profilename = "";
  String bookeddate = "";
  int selectedDayId = 0;
  int selectedIdx = -1;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
  getDayId(String abr) {
    switch (abr) {
      case "Sun":
        dayId = 0;
        break;
      case "Mon":
        dayId = 1;
        break;
      case "Tue":
        dayId = 2;
        break;
      case "Wed":
        dayId = 3;
        break;
      case "Thu":
        dayId = 4;
        break;
      case "Fri":
        dayId = 5;
        break;
      case "Sat":
        dayId = 6;
        break;
    }
  }


  intMyPackage(
      {required Widget widget,
        required String title,
        required List<ScheduleModel> gridData,
        required GridDetail gridDetail}) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<GridRepository>(
          create: (context) => GridRepository(),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<GridBloc>(
          create: (context) => GridBloc(
            gridRepository: RepositoryProvider.of<GridRepository>(context),
          )..add(GridEventCreateSchedule(
              title: title, gridData: gridData, gridDetail: gridDetail)),
        )
      ], child: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Container();
  }




}