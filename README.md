<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Flutter Grid Schedule Calender.

## Features

TODO: You can create Schedule Based Grid Calender Instantly

## Getting started

TODO:  pub add gridschedule

## Usage

Widget build(BuildContext context) {
GridDetail gridDetail = GridDetail(
lable: "Grid",
costPerGrid: 10,
arrowButtonColor: Color.fromARGB(255, 183, 200, 255).withOpacity(0.3),
gridCount: 3);

    List<Schedule> schedule = [
      Schedule(
          day: 0,
          time: "1.00-2.00",
          availability: 1,
          timeAvailableColor: Colors.pink,
          timeUnavailableColor: Colors.lightGreen,
          timeAvailableTextColor: Colors.black,
          timeUnavailableTextColor: Colors.black,
          onTapTimeAvailable: (p0) {
            var tm = p0 as Schedule;
            print(tm.time);
          },
          onTapTimeUnavailable: (args) {
            //  args as Sched
          }),
      Schedule(
          day: 0,
          time: "2.00-3.00",
          availability: 1,
          timeAvailableColor: Colors.pink,
          timeUnavailableColor: Colors.lightGreen,
          timeAvailableTextColor: Colors.white,
          timeUnavailableTextColor: Colors.black,
          onTapTimeAvailable: (p0) {
            var tm = p0 as Schedule;
            print(tm.time);
          },
          onTapTimeUnavailable: (args) {
            print(args);
          }),
    ];

    return SafeArea(
      child: Scaffold(
          body: GridScheduleWidget(
              title: "Grid Schedule",
              schedule: schedule,
              gridDetail: gridDetail)),
    );
}

  

```dart
const like = 'sample';
```

## Additional information

You can raised issues in this repo https://github.com/praneethpj/GridSchduleCalender/issues
