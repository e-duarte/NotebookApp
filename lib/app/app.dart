import 'package:flutter/material.dart';
import 'package:notebook_app/app/models/manager.dart';
import 'package:notebook_app/app/models/scheduling.dart';
import 'package:notebook_app/app/models/users.dart';
import 'package:notebook_app/app/pages/agenda.dart';
import 'package:notebook_app/app/pages/feed.dart';
import 'package:notebook_app/app/pages/home.dart';
import 'package:notebook_app/app/pages/login.dart';
import 'package:notebook_app/app/pages/manager_page.dart';
import 'package:notebook_app/app/pages/schedulingPage.dart';
import 'package:notebook_app/app/pages/storeUserPager.dart';
import 'package:notebook_app/app/pages/usersPage.dart';
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
        ChangeNotifierProvider(
          create: (context) => Schedulings(),
        ),
        ChangeNotifierProvider(
          create: (context) => Users(),
        ),
        Provider(create: (context) => Login()),
        Provider(create: (context) => Home()),
        Provider(create: (context) => Feed()),
        Provider(create: (context) => Agenda()),
        Provider(create: (context) => SchedulingPage()),
        Provider(create: (context) => UsersPage()),
        Provider(create: (context) => StoreUserPage()),
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
          '/scheduling': (context) => SchedulingPage(),
          '/storeuserpage': (context) => StoreUserPage(),
        },
      ),
    );
  }
}
