import 'package:weather_app/core/services/api/api_client/api_client.dart';
import 'package:weather_app/weather_forecast/models/weather.dart';

import '../../core/services/api/api_config/app_config.dart';

abstract class WeatherForecastRepo {
  Future<Weather> getWeatherForecast(String lat, String long, String days);
}

class WeatherApiService implements WeatherForecastRepo {
  ApiClient client = ApiClient();

  @override
  Future<Weather> getWeatherForecast(
      String lat, String long, String days) async {
    String url = "${ApiConfig.baseWeatherUrl}&q=$lat,$long&days=$days";
    Uri uri = Uri.parse(url);

    final response = await client.get(uri);

    var weather = weatherFromJson(response);

    return weather;
  }
}
