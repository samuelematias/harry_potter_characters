import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';
import '../storage/storage.dart';
import '../widgets/widgets.dart';

class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({Key key}) : super(key: key);

  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  final HpController _controller = HpController();
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
        title: const Text('List of favorite characters'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => _Body(
              controller: _controller,
              charactersStorage: _charactersStorage,
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    @required this.controller,
    @required this.charactersStorage,
    Key key,
  }) : super(key: key);
  final HpController controller;
  final CharactersStorage charactersStorage;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: _List(
        controller: controller,
        charactersStorage: charactersStorage,
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({
    @required this.controller,
    @required this.charactersStorage,
    Key key,
  }) : super(key: key);
  final HpController controller;
  final CharactersStorage charactersStorage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CharactersStorage>(
        stream: charactersStorage.stream,
        builder: (context, snapshot) {
          final List<HpCharactersModel> cx =
              charactersStorage?.readCharacters ?? [];
          if (cx.isEmpty || cx == null) {
            return const Center(child: Text('No favorite characters yet'));
          }
          return ListView.builder(
            itemCount: cx.length,
            itemBuilder: (BuildContext context, int index) {
              final HpCharactersModel character = cx[index];
              final String imageURLHttps =
                  controller.imageURLToHttps(urlHttp: character.image);
              return ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  child: ClipOval(
                    child: ImageFadeIn(imageURL: imageURLHttps),
                  ),
                ),
                title: Text(character.name),
                subtitle: Text(character.house),
                trailing: const FavoriteButton(
                  tooltipMessage: 'Unfavorite Character',
                ),
                onTap: () => charactersStorage.removeCharacter(
                  'characters',
                  character,
                ),
              );
            },
          );
        });
  }
}
