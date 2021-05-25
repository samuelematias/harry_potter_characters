import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../pages/pages.dart';
import '../storage/storage.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  CharactersStorage _charactersStorage;

  @override
  void initState() {
    super.initState();
    _charactersStorage = CharactersStorage();
    _charactersStorage.init();
  }

  @override
  void dispose() {
    _charactersStorage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //Transparent statusBar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        Provider<CharactersStorage>.value(value: _charactersStorage),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Harry Potter Characters',
        home: const CharactersListPage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
