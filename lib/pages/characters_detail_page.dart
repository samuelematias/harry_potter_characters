import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';
import '../storage/storage.dart';
import '../widgets/widgets.dart';

class CharacterDetailPage extends StatefulWidget {
  const CharacterDetailPage({@required this.character, Key key})
      : super(key: key);
  final HpCharactersModel character;

  @override
  _CharacterDetailPageState createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  CharactersStorage _charactersStorage;

  @override
  void initState() {
    super.initState();
    _charactersStorage = context.read<CharactersStorage>();
  }

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
              onTap: () => _charactersStorage.saveCharacter(
                'characters',
                widget.character,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _Body(character: widget.character),
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
              Flexible(
                child: Text(
                  character.name,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
