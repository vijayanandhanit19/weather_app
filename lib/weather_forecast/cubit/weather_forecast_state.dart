part of 'weather_forecast_cubit.dart';

class WeatherForecastState {
  const WeatherForecastState({
    this.status = "",
    this.errorMessage,
    this.weather,
  });

  final String status;
  final String? errorMessage;
  final Weather? weather;

  WeatherForecastState copyWith({
    String? status,
    String? errorMessage,
    Weather? weather,
  }) {
    return WeatherForecastState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        weather: weather ?? this.weather);
  }
}
