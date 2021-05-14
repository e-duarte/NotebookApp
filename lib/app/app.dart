import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/pages/agenda.dart';
import 'package:notebook_app/app/pages/feed.dart';
import 'package:notebook_app/app/pages/home.dart';
import 'package:notebook_app/app/pages/login.dart';
import 'package:notebook_app/app/pages/manager_page.dart';
import 'package:notebook_app/app/pages/scheduling.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Manager(),
        ),
        Provider(create: (context) => Login()),
        Provider(create: (context) => Home()),
        Provider(create: (context) => Feed()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NotebookApp',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('pt', ''), // Spanish, no country code
        ],
        locale: const Locale('pt'),
        theme: ThemeData(
          primaryColor: Colors.cyan,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Home(),
          '/manager': (context) => ManagerPage(),
          '/agenda': (context) => Agenda(),
          '/scheduling': (context) => Scheduling(),
        },
      ),
    );
  }
}
