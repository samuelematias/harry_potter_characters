import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';

class CharactersListPage extends StatefulWidget {
  const CharactersListPage({Key key}) : super(key: key);

  @override
  _CharactersListPageState createState() => _CharactersListPageState();
}

class _CharactersListPageState extends State<CharactersListPage> {
  final HpController _controller = HpController();

  @override
  void initState() {
    super.initState();
    _controller.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => _Body(controller: _controller),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({@required this.controller, Key key}) : super(key: key);
  final HpController controller;

  @override
  Widget build(BuildContext context) {
    final bool isLoading = controller.value == HpState.loading;
    final bool isError = controller.value == HpState.error;

    if (isError) {
      return Center(
        child: ElevatedButton(
          onPressed: () => controller.getCharacters(),
          child: const Text('Try Again'),
        ),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 700),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _List(controller: controller),
    );
  }
}

class _List extends StatelessWidget {
  const _List({@required this.controller, Key key}) : super(key: key);
  final HpController controller;

  @override
  Widget build(BuildContext context) {
    final List<HpCharactersModel> characters = controller.characters;

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (BuildContext context, int index) {
        final HpCharactersModel character = characters[index];
        final String imageURLHttps =
            controller.imageURLToHttps(urlHttp: character.image);
        return ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            child: ClipOval(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageURLHttps,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported);
                },
                fit: BoxFit.cover,
                width: 50,
              ),
            ),
          ),
          title: Text(character.name),
          subtitle: Text(character.house),
          onTap: () {},
        );
      },
    );
  }
}
