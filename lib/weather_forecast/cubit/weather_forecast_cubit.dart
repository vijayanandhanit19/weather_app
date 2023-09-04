import 'package:bloc/bloc.dart';
import 'package:weather_app/weather_forecast/models/weather.dart';

import '../../core/constants/string_constants.dart';
import '../../core/enums/weather_enums.dart';
import '../../core/services/location/geo_location_service.dart';
import '../repositories/weather_forecast_repo.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit() : super(const WeatherForecastState());

  Future<void> getWeather() async {
    String days = StringConstants.weatherForecastDays;
    try {
      WeatherApiService weatherApiService = WeatherApiService();
      emit(state.copyWith(
        status: BlocStatus.inProgress.name,
      ));
      var position = await getPosition();

      var response = await weatherApiService.getWeatherForecast(
          position.latitude.toString(), position.longitude.toString(), days);
      emit(state.copyWith(
        status: BlocStatus.success.name,
        weather: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.fail.name,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> cleatWeatherForecastState() async {
    emit(state.copyWith(
      status: '',
      errorMessage: '',
    ));
  }
}
