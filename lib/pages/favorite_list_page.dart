import 'package:flutter/material.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('List of favorite characters'),
      ),
    );
  }
}
