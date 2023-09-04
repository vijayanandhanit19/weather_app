import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/string_constants.dart';

void showDialogBox(BuildContext context, weatherCubit) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text(StringConstants.serviceDown),
        content: const Text(StringConstants.serviceError),
        actions: <Widget>[
          TextButton(
            child: const Text(StringConstants.tryAgain),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await weatherCubit.cleatWeatherForecastState();
              weatherCubit.getWeather();
            },
          ),
        ],
      );
    },
  );
}
