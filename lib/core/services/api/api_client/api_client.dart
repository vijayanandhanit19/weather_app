import 'package:weather_app/core/services/api/api_client/handle_response.dart';
import 'package:http/http.dart' as http;

import '../../../constants/string_constants.dart';

class ApiClient {
  HandleResponse handleResponse = HandleResponse();

  Future<dynamic> get(Uri uri) async {
    try {
      final response = await http.get(uri);
      return handleResponse.handleHttpResponse(response);
    } catch (e) {
      throw (StringConstants.unknowApiError);
    }
  }
}
