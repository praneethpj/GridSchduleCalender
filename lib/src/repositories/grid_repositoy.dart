
import 'package:gridschedule/src/helper/data_helper.dart';
import 'package:gridschedule/src/models/grid_detail.dart';
import 'package:gridschedule/src/models/schedule.dart';

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class GridRepository {
  List<Schedule> _schedule = [];
  late GridDetail _gridDetail;
  bool isToday = true;

  String currentDay = "";
  String currentMonth = "";
  String currentYear = "";
  int currentMonthNum = 0;
  int dayId = 0;

  int selectedDayId = 0;
  int selectedIdx = -1;

  initData() {
    DataHelper.init();
    currentDay = DataHelper.currentDate;
    currentMonth = DataHelper.currentMonth;
    currentMonthNum = DataHelper.currentMonthNum;
    currentYear = DataHelper.currentYear;
    isToday = true;

    setToday();
  }

  Future<void> createSchedules(
      List<Schedule> schedule, GridDetail gridDetails) async {
    _schedule = schedule;
    _gridDetail = gridDetails;

    currentMonth = DataHelper.getCurrentMonth();
    currentDay = DataHelper.getCurrentDay();
  }

  getGridDetails() {
    return _gridDetail;
  }

  Future<List<Schedule>> getSchedules() async {
    List<Schedule> tmpSchedule = [];
    _schedule.forEach((element) {
      if (element.day == dayId) {
        tmpSchedule.add(element);
      }
    });
    return tmpSchedule;
  }

  Future<void> substractDate() async {
    DateTime d = Jiffy.now().dateTime;
    DateTime date = Jiffy.parseFromDateTime(
            DateTime(d.year, currentMonthNum, int.parse(currentDay)))
        .subtract(days: 1)
        .dateTime;

    currentDay = DateFormat('d').format(date);
    currentMonth = DateFormat('MMM').format(date);
    currentMonthNum = int.parse(DateFormat('M').format(date));
    checkToday();
  }

  Future<void> addDate() async {
    DateTime d = Jiffy.now().dateTime;
    DateTime date = Jiffy.parseFromDateTime(
            DateTime(d.year, currentMonthNum, int.parse(currentDay)))
        .add(days: 1)
        .dateTime;

    currentDay = DateFormat('d').format(date);
    currentMonth = DateFormat('MMM').format(date);
    currentMonthNum = int.parse(DateFormat('M').format(date));
    currentYear = DateFormat('yyy').format(date);
    //setState(() {});
    checkToday();
  }

  checkToday() {
    DateTime d = Jiffy.now().dateTime;
    DateTime date2 = Jiffy.parseFromDateTime(
            DateTime(d.year, currentMonthNum, int.parse(currentDay)))
        .dateTime;
    if (calculateDifference(date2) <= 0) {
      isToday = true;
    } else {
      isToday = false;
    }

    getDayId(DateFormat("E").format(date2));
    // print(dayId
    // );
  }

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

  setToday() {
    DateTime d = Jiffy.now().dateTime;
    DateTime date2 = Jiffy.parseFromDateTime(
            DateTime(d.year, currentMonthNum, int.parse(currentDay)))
        .dateTime;

    getDayId(DateFormat("E").format(date2));
  }
}
