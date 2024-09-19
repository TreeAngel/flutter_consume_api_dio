import 'package:dio/dio.dart';

class ApiController {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/';
  static String? token;
  static var dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      sendTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    ),
  );

  static Future getData(String url) async {
    try {
      final response = await dio.get(
        url,
        options: token != null
            ? Options(headers: {'Authorization': 'Bearer $token'})
            : null,
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return response.data;
      } else {
        throw Exception(
            'Status code: ${response.statusCode} | Message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future postData(String url, dynamic data) async {
    try {
      final response = await dio.post(
        url,
        options: token != null
            ? Options(headers: {'Authorization': 'Bearer $token'})
            : null,
        data: data,
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return response.data;
      } else {
        throw Exception(
            'Status code: ${response.statusCode} | Message: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
