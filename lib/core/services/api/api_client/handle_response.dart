import 'dart:convert';

import 'package:http/http.dart' as http;

class HandleResponse {
  factory HandleResponse() {
    return _singleton;
  }

  HandleResponse._();
  static final HandleResponse _singleton = HandleResponse._();

  dynamic handleHttpResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw ('API ERROR: ${response.statusCode}, ${response.body}');
    }
  }
}
