import 'package:flutter/material.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const <Widget>[Text('Harry Potter Characters List')],
        ),
      ),
    );
  }
}
