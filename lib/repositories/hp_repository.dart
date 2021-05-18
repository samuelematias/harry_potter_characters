import 'package:dio/dio.dart';
import '../constants/base_url.dart';
import '../models/models.dart';

class HpRepository {
  HpRepository([Dio client]) : dio = client ?? Dio();

  Dio dio;

  Future<List<CharactersModel>> getCharacters() async {
    final String _url = '$baseURL/characters';
    final response = await dio.get<Map<String, Object>>(_url);
    // final List list = response.data as List;
    // return list.map((json) => CharactersModel.fromJson(json)).toList();
    // return CharactersModel.fromJson(response.data);

    // return response.map((json) => CharactersModel.fromJson(json)).toList();

    if (response.statusCode == 200) {
      final List<CharactersModel> jsonResponse =
          response.data as List<CharactersModel>;
      return jsonResponse
          .map((CharactersModel character) =>
              CharactersModel.fromJson(character as Map<String, Object>))
          .toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
