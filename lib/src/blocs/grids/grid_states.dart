part of 'grid_bloc.dart';

abstract class GridState extends Equatable {
  @override
  List<Object> get props => [];
}

class GridStateInit extends GridState {}

class GridStateCreateSchedule extends GridState {
  GridRepository gridRepository;
  GridStateCreateSchedule({required this.gridRepository});

  @override
  List<Object> get props => [];
}

class GridStateNextDay extends GridState {
  String currentDay = "";
  GridRepository gridRepository;

  @override
  List<Object> get props => [currentDay];
  GridStateNextDay({required this.currentDay, required this.gridRepository});
}

class GridStateBackDay extends GridState {
  String currentDay = "";
  GridRepository gridRepository;
  GridStateBackDay({required this.gridRepository});
  @override
  List<Object> get props => [currentDay];
}
