
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_schedule_calender/grid_schedule_calender.dart';

import 'package:grid_schedule_calender/src/repositories/grid_repositoy.dart';


part 'grid_events.dart';
part 'grid_states.dart';

class GridBloc extends Bloc<GridEvent, GridState> {
  GridRepository gridRepository;

  GridBloc({required this.gridRepository}) : super(GridStateInit()) {
    on<GridEventCreateSchedule>((event, state) {
      gridRepository.initData();
      gridRepository.createSchedules(event.schedule, event.gridDetail).then(
          (value) =>
              emit(GridStateCreateSchedule(gridRepository: gridRepository)));
    });

    on<GridEventClickNext>((event, state) {
      gridRepository.addDate().then((value) => emit(GridStateNextDay(
          currentDay: event.day, gridRepository: gridRepository)));
    });

    on<GridEventClickBack>((event, state) {
      gridRepository.substractDate().then((value) => emit(GridStateNextDay(
          currentDay: event.day, gridRepository: gridRepository)));
    });
  }
}
