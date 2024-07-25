
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

Future<void> uploadImageToYandexCloud(String name,String path) async {

  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/upload',
    {
      "path": name,
    },
  );

  /// Токен авторизации, можно получить по ссылке https://yandex.ru/dev/disk/poligon/ выполнив вход
  const token = 'y0_AgAAAAB3kqFjAADLWwAAAAELdIw3AACTsZ5XnU5JK6vDwoFxopSJi65KiA';

  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );

  final body = response.body;
  final json = jsonDecode(body);
  json as Map<String, dynamic>;
  final linkToUpload = json['href'] as String;

  // ### Загружаем файл на сервер

  final dio = Dio();
  final file = File(path);
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path),
  });
  dio.put(linkToUpload, data: formData);
}