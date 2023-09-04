import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/size_constants.dart';
import 'package:weather_app/core/constants/text_style_constants.dart';
import 'package:weather_app/core/enums/weather_enums.dart';
import 'package:weather_app/weather_forecast/cubit/weather_forecast_cubit.dart';

import '../../core/constants/string_constants.dart';
import '../widgets/dialog_box.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late WeatherForecastCubit weatherCubit = WeatherForecastCubit();
  late String temp;
  late DateTime date;
  bool switchDay = false;

  @override
  void initState() {
    weatherCubit = BlocProvider.of<WeatherForecastCubit>(context);
    weatherCubit.getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.appBarTitle),
        centerTitle: true,
      ),
      body: BlocConsumer<WeatherForecastCubit, WeatherForecastState>(
        listener: (context, state) {
          if (state.status == BlocStatus.fail.name) {
            showDialogBox(context, weatherCubit);
          }
        },
        builder: (context, state) {
          if (state.status == BlocStatus.success.name) {
            setInitialDateTime(state);

            return Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(SizeConstants.defaultNumber16)),
                  ),
                  padding: const EdgeInsets.all(SizeConstants.defaultNumber16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: SizeConstants.defaultNumber16,
                      ),
                      Text(DateFormat.yMMMMd(StringConstants.enUS).format(date),
                          style: TextStyleConstants.styleBlack24),
                      const SizedBox(
                        height: SizeConstants.defaultNumber32,
                      ),
                      Text(
                          "${state.weather!.location.name},${state.weather!.location.country} ",
                          style: TextStyleConstants.styleBlack24),
                      const SizedBox(
                        height: SizeConstants.defaultNumber16,
                      ),
                      Text("$temp ${StringConstants.celsiusSymbox}",
                          style: TextStyleConstants.styleBlack24w800),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: SizeConstants.defaultNumber100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.weather!.forecast.forecastday.length,
                    itemBuilder: ((context, index) {
                      String dayOfWeek = getDayOfWeek(
                          state.weather!.forecast.forecastday[index].date);

                      return Container(
                        width: SizeConstants.defaultNumber100,
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(SizeConstants.defaultNumber16),
                            ),
                            border: Border.all(color: Colors.grey)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              switchDay = true;
                              temp = state.weather!.forecast.forecastday[index]
                                  .day.avgtempC
                                  .toString();
                              date = state
                                  .weather!.forecast.forecastday[index].date;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dayOfWeek),
                              const Icon(Icons.cloud),
                              Text(
                                  "${state.weather!.forecast.forecastday[index].day.avgtempC.toString()} ${StringConstants.celsiusSymbox}"),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void setInitialDateTime(WeatherForecastState state) {
    if (!switchDay) {
      date = state.weather!.forecast.forecastday[0].date;
      temp = state.weather!.forecast.forecastday[0].day.avgtempC.toString();
    }
  }

  String getDayOfWeek(DateTime date) {
    int dayIndex = date.weekday - 1;
    return StringConstants.daysOfWeek[dayIndex];
  }
}
