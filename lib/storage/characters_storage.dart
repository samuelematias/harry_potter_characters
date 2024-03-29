import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class CharactersStorage {
  static SharedPreferences _prefs;
  bool get isReady => _prefs != null;
  final _controller = StreamController<CharactersStorage>.broadcast();
  Stream<CharactersStorage> get stream => _controller.stream;
  List<HpCharactersModel> charactersList = [];

  void dispose() {
    _controller?.close();
  }

  Future<bool> init() async {
    _controller.add(this);
    _prefs = await SharedPreferences.getInstance();
    _controller.add(this);
    return isReady;
  }

  List<HpCharactersModel> get readCharacters {
    if (_prefs.getString('characters') == null) {
      return [];
    }
    final List<dynamic> list =
        json.decode(_prefs.getString('characters')) as List<dynamic>;
    if (list.isEmpty || list == null) {
      return [];
    }
    return list
            .cast<Map<String, Object>>()
            .map<HpCharactersModel>(
                (character) => HpCharactersModel.fromJson(character))
            .toList() ??
        [];
  }

  Future saveCharacter(
    String key,
    HpCharactersModel character,
  ) async {
    if (!isReady) {
      await init();
    }
    final HpCharactersModel characterAlreadyExist = charactersList.firstWhere(
      (characterItem) => characterItem.name == character.name,
      orElse: () => null,
    );

    if (characterAlreadyExist == null) {
      charactersList.add(HpCharactersModel(
        name: character.name,
        image: character.image,
        house: character.house,
      ));
      _prefs.setString(
        key,
        json.encode(
          charactersList
              .map<Map<String, Object>>(
                  (character) => HpCharactersModel.toMap(character))
              .toList(),
        ),
      );
      _controller.add(this);
    }
  }

  FutureOr<void> removeCharacter(
    String key,
    HpCharactersModel character,
  ) async {
    if (!isReady) {
      await init();
    }
    if (_prefs.getString('characters') != null) {
      final List<dynamic> list =
          json.decode(_prefs.getString('characters')) as List<dynamic>;

      list
          .cast<Map<String, Object>>()
          .removeWhere((char) => char.containsValue(character.name));

      _prefs.setString(
        key,
        json.encode(list),
      );
      _controller.add(this);
    }
  }
}
