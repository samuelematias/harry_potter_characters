import 'package:flutter/material.dart';

import '../models/models.dart';
import '../repositories/hp_repository.dart';

class HpController {
  HpController([HpRepository repository])
      : _repository = repository ?? HpRepository();

  List<CharactersModel> characters = [];
  final HpRepository _repository;
  final ValueNotifier<HpState> state = ValueNotifier<HpState>(HpState.loading);

  Future getCharacters() async {
    try {
      state.value = HpState.loading;
      characters = await _repository.getCharacters();
      state.value = HpState.success;
    } catch (e) {
      state.value = HpState.error;
    }
  }
}

enum HpState { loading, success, error }
