import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'error_handling.dart';
class Request {
  final _baseUrl = dotenv.env['BASE_URL'];

  final _errorHandling = ErrorHandling();
  final Duration _timeOut = Duration(seconds: 60);


  Future<dynamic> getData(String url,
      {Map<String, String?>? queryParams}) async {
    log(_baseUrl!  + url);

    try {
      http.Response response = await http
          .get(Uri.parse(_baseUrl!  + url),
             )
          .timeout(_timeOut, onTimeout: () async {
        return await _errorHandling.manageErrors(_timeoutResponse());
      });

      return await _errorHandling.manageErrors(response);
    } catch (err) {
      log(err.toString());
        throw Exception(err);


    }
  }




  http.Response _timeoutResponse() {
    return http.Response(
      jsonEncode({
        "success": false,
        "message": "Please check your network connection and try again."
      }),
      401,
      headers: {'Content-Type': 'application/json'},
    );
  }



}
