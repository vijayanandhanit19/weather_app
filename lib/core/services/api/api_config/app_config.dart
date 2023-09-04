class ApiConfig {
  // Weather API server
  static const String baseUrl = "https://api.weatherapi.com/v1/forecast.json";

  // Weather API Key
  static const String apiKey = "5b4c657df20447f786552348230109";

  // Base Weather URL
  static const String baseWeatherUrl = "$baseUrl?key=$apiKey";
}
