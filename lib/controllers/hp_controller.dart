import 'package:flutter/material.dart';

import '../models/models.dart';
import '../repositories/hp_repository.dart';

class HpController extends ValueNotifier<HpState> {
  HpController([HpRepository repository])
      : _repository = repository ?? HpRepository(),
        super(HpState.loading);

  List<HpCharactersModel> characters = [];
  final HpRepository _repository;

  Future getCharacters() async {
    try {
      value = HpState.loading;
      characters = await _repository.getCharacters();

      value = HpState.success;
    } catch (e) {
      value = HpState.error;
    }
  }

  String imageURLToHttps({String urlHttp}) =>
      urlHttp.replaceAll('http://', 'https://');
}

enum HpState { loading, success, error }
