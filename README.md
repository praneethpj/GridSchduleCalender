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

void available(args) {
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text(args.time.toString())));
}

    void unavailable(args) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(args.time.toString())));
    }

    List<ScheduleModel> gridData = [
      ScheduleModel(
        day: 6,
        time: "13:00-13:30",
        availability: 0,
        timeAvailableColor: Colors.purple,
        timeUnavailableColor: Colors.grey,
        timeAvailableTextColor: Colors.black,
        timeUnavailableTextColor: Colors.black,
        onTapTimeAvailable: (object) => available(object),
        onTapTimeUnavailable: (object) => unavailable(object),
      ),
      ScheduleModel(
        day: 6,
        time: "14:00-13:30",
        availability: 1,
        timeAvailableColor: Colors.purple,
        timeUnavailableColor: Colors.grey,
        timeAvailableTextColor: Colors.black,
        timeUnavailableTextColor: Colors.white,
        onTapTimeAvailable: (object) => available(object),
        onTapTimeUnavailable: (object) => unavailable(object),
      ),
      ScheduleModel(
        day: 6,
        time: "14:00-13:30",
        availability: 1,
        timeAvailableColor: Colors.purple,
        timeUnavailableColor: Colors.grey,
        timeAvailableTextColor: Colors.black,
        timeUnavailableTextColor: Colors.white,
        onTapTimeAvailable: (object) => available(object),
        onTapTimeUnavailable: (object) => unavailable(object),
      ),
    ];

    GridDetail gridDetail = GridDetail(
        lable: "Grid",
        costPerGrid: 10,
        arrowButtonColor: Color.fromARGB(255, 183, 200, 255).withOpacity(0.3),
        gridCount: 3);

    return intMyPackage(
        title: "Call Schedule",
        gridData: gridData,
        gridDetail: gridDetail,

```dart
const like = 'sample';
```

## Additional information

You can raised issues in this repo https://github.com/praneethpj/GridSchduleCalender/issues
