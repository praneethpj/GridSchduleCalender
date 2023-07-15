
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_schedule_calender/grid_schedule_calender.dart';
import 'package:grid_schedule_calender/src/models/schedule.dart';
import 'package:grid_schedule_calender/src/models/grid_detail.dart';
import 'package:grid_schedule_calender/src/blocs/grids/grid_bloc.dart';
import 'package:grid_schedule_calender/src/repositories/grid_repositoy.dart';


class GridScheduleWidget extends StatelessWidget {
  final String title;
  final List<Schedule> schedule;
  final  GridDetail gridDetail;
   const GridScheduleWidget({super.key, required this.title, required this.schedule, required this.gridDetail});

  _intGridSchedulePackage(
      {required Widget widget,
        required String title,
        required List<Schedule> schedule,
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
              title: title, schedule: schedule, gridDetail: gridDetail)),
        )
      ], child: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;

    return _intGridSchedulePackage(
        title: title,
        schedule: schedule,
        gridDetail: gridDetail,
        widget: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: BlocBuilder<GridBloc, GridState>(
                builder: (context, state) {
                  if (state is GridStateCreateSchedule) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: _deviceSize.height * 0.08,
                          child: Container(
                            margin:
                            EdgeInsets.only(left: _deviceSize.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: state.gridRepository.isToday
                                      ? IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.arrow_left))
                                      : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: state.gridRepository
                                              .getGridDetails()
                                              .arrowButtonColor,
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                          // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      onPressed: () => context
                                          .read<GridBloc>()
                                          .add(GridEventClickBack(
                                          title: "",
                                          day: state.gridRepository
                                              .currentDay,
                                          schedule: schedule,
                                          gridDetail: gridDetail)),
                                      icon: const Icon(Icons.arrow_back),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: _deviceSize.width / 6,
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${state.gridRepository.currentMonth}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${state.gridRepository.currentDay}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: _deviceSize.width / 6,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: state.gridRepository
                                              .getGridDetails()
                                              .arrowButtonColor,
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                          // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      onPressed: () => context
                                          .read<GridBloc>()
                                          .add(GridEventClickNext(
                                          title: "",
                                          day: state
                                              .gridRepository.currentDay,
                                          schedule: schedule,
                                          gridDetail: gridDetail)),
                                      icon: const Icon(Icons.arrow_right),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _deviceSize.height * 0.01,
                        ),
                        FutureBuilder(
                          future: state.gridRepository.getSchedules(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: _deviceSize.height,
                                width: _deviceSize.width,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: state.gridRepository
                                        .getGridDetails()
                                        .gridCount,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (snapshot.data![index]
                                                .availability ==
                                                1) {
                                              snapshot.data![index]
                                                  .onTapTimeAvailable(
                                                  snapshot.data![index]);
                                              ;
                                            } else {
                                              snapshot.data![index]
                                                  .onTapTimeUnavailable(
                                                  snapshot.data![index]);
                                              ;
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 199, 199, 199),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: snapshot.data![index]
                                                    .availability ==
                                                    1
                                                    ? state.gridRepository
                                                    .selectedIdx ==
                                                    index
                                                    ? snapshot.data![index]
                                                    .timeAvailableColor
                                                    : snapshot.data![index]
                                                    .timeUnavailableColor
                                                    : Color.fromARGB(
                                                    255, 236, 235, 235),
                                              ),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: state.gridRepository
                                                      .selectedIdx ==
                                                      index &&
                                                      snapshot.data![index]
                                                          .availability ==
                                                          1
                                                      ? Text(
                                                    "${snapshot.data![index].time}",
                                                    style: TextStyle(
                                                      color: snapshot
                                                          .data![index]
                                                          .timeUnavailableTextColor,
                                                      fontSize:snapshot.data![index].timeAvailableTextSize
                                                    ),
                                                  )
                                                      : Text(
                                                    "${snapshot.data![index].time}",
                                                    style: TextStyle(
                                                        color: snapshot
                                                            .data![index]
                                                            .timeUnavailableTextColor, fontSize:snapshot.data![index].timeUnavailableTextSize),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else if (state is GridStateNextDay) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: _deviceSize.height * 0.08,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: state.gridRepository.isToday
                                    ? IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.arrow_left))
                                    : Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: state.gridRepository
                                            .getGridDetails()
                                            .arrowButtonColor,
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () => context
                                        .read<GridBloc>()
                                        .add(GridEventClickBack(
                                        title: "",
                                        day: state.gridRepository
                                            .currentDay,
                                        schedule: schedule,
                                        gridDetail: gridDetail)),
                                    icon: const Icon(Icons.arrow_left),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: _deviceSize.width / 6,
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "${state.gridRepository.currentMonth}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${state.gridRepository.currentDay}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: _deviceSize.width / 6,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: state.gridRepository
                                            .getGridDetails()
                                            .arrowButtonColor,
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () => {
                                      context.read<GridBloc>().add(
                                          GridEventClickNext(
                                              title: "",
                                              day: state
                                                  .gridRepository.currentDay,
                                              schedule: schedule,
                                              gridDetail: gridDetail))
                                    },
                                    icon: Icon(Icons.arrow_right),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _deviceSize.height * 0.01,
                        ),
                        FutureBuilder(
                          future: state.gridRepository.getSchedules(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: _deviceSize.height,
                                child: GridView.builder(
                                  itemCount: snapshot.data!.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: state.gridRepository
                                        .getGridDetails()
                                        .gridCount,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (snapshot.data![index]
                                                .availability ==
                                                1) {
                                              snapshot.data![index]
                                                  .onTapTimeAvailable(
                                                  snapshot.data![index]);
                                            } else {
                                              snapshot.data![index]
                                                  .onTapTimeUnavailable(
                                                  snapshot.data![index]);
                                            }
                                          },
                                          child: Container(
                                            width: _deviceSize.width,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color.fromARGB(
                                                    255, 199, 199, 199),
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: snapshot.data![index]
                                                  .availability ==
                                                  1
                                                  ? state.gridRepository
                                                  .selectedIdx ==
                                                  index
                                                  ? snapshot.data![index]
                                                  .timeAvailableColor
                                                  : snapshot.data![index]
                                                  .timeUnavailableColor
                                                  : Color.fromARGB(
                                                  255, 236, 235, 235),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: state.gridRepository
                                                    .selectedIdx ==
                                                    index &&
                                                    snapshot.data![index]
                                                        .availability ==
                                                        1
                                                    ? Text(
                                                  "${snapshot.data![index].time}",
                                                  style: TextStyle(
                                                    color: snapshot
                                                        .data![index]
                                                        .timeAvailableTextColor,
                                                      fontSize:snapshot.data![index].timeAvailableTextSize
                                                  ),
                                                )
                                                    : Text(
                                                  "${snapshot.data![index].time}",
                                                  style: TextStyle(
                                                      color: snapshot
                                                          .data![index]
                                                          .timeUnavailableTextColor, fontSize:snapshot.data![index].timeUnavailableTextSize),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ));
  }
}
