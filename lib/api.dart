import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static Future<(String?, dynamic)> getRequest(
      String url, Map<String, String>? headers) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return (null, jsonDecode(response.body));
      } else {
        return (response.body, null);
      }
    } catch (e) {
      return (e.toString(), null);
    }
  }
}
