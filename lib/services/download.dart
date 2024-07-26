import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> downloadFile(String path, String savePath) async {
  final uri = Uri.https(
    'cloud-api.yandex.net',
    'v1/disk/resources/download',
    {
      'path': path,
    },
  );

  // Токен авторизации
  const token = 'y0_AgAAAAB3kqFjAADLWwAAAAELdIw3AACTsZ5XnU5JK6vDwoFxopSJi65KiA';

  // Получение ссылки на скачивание файла
  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: 'OAuth $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Ошибка при получении ссылки на скачивание: ${response.body}');
  }

  final body = response.body;
  final json = jsonDecode(body) as Map<String, dynamic>;
  final downloadUrl = json['href'] as String;

  // Скачивание файла
  final fileResponse = await http.get(Uri.parse(downloadUrl));

  if (fileResponse.statusCode != 200) {
    throw Exception('Ошибка при скачивании файла: ${fileResponse.body}');
  }

  final file = File(savePath);
  await file.writeAsBytes(fileResponse.bodyBytes);

  print('Файл успешно скачан и сохранен в $savePath');
}
