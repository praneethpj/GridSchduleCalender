part of 'grid_bloc.dart';

abstract class GridEvent extends Equatable {
  List<Object> get props => [];
}

class GridEventCreateSchedule extends GridEvent {
  String title;
  List<ScheduleModel> gridData;
  GridDetail gridDetail;
  GridEventCreateSchedule(
      {required this.title, required this.gridData, required this.gridDetail});
}

class GridEventClickNext extends GridEvent {
  String title;
  String day;
  List<ScheduleModel> gridData;
  GridDetail gridDetail;
  GridEventClickNext(
      {required this.title,
      required this.day,
      required this.gridData,
      required this.gridDetail});
}

class GridEventClickBack extends GridEvent {
  String title;
  String day;
  List<ScheduleModel> gridData;
  GridDetail gridDetail;
  GridEventClickBack(
      {required this.title,
      required this.day,
      required this.gridData,
      required this.gridDetail});
}
