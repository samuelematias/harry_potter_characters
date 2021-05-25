import 'package:flutter/material.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class CharacterDetailPage extends StatelessWidget {
  const CharacterDetailPage({@required this.character, Key key})
      : super(key: key);
  final HpCharactersModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Character detail'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FavoriteButton(
              tooltipMessage: 'Add Character as Favorite',
              onTap: () {},
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _Body(character: character),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({@required this.character, Key key}) : super(key: key);
  final HpCharactersModel character;

  @override
  Widget build(BuildContext context) {
    final HpController controller = HpController();
    final String imageURLHttps =
        controller.imageURLToHttps(urlHttp: character.image);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageFadeIn(imageURL: imageURLHttps, width: 200),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    character.house,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
