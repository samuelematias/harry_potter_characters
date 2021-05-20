import 'package:dio/dio.dart';

import '../constants/base_url.dart';
import '../models/models.dart';

class HpRepository {
  HpRepository([Dio client]) : dio = client ?? Dio();

  Dio dio;

  Future<List<HpCharactersModel>> getCharacters() async {
    try {
      final String url = '$baseURL/characters';
      final response = await dio.get<List<Object>>(url);

      return response.data
          .cast<Map<String, Object>>()
          .map((e) => HpCharactersModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load data from API');
    }
  }
}
