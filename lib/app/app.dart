import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:tcp_penguin/app/localization/app_localizations.dart';
import 'package:tcp_penguin/app/navigation/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightColorScheme =
            lightDynamic ??
            ColorScheme.fromSeed(
              seedColor: Colors.pink,
              brightness: Brightness.light,
            );

        final darkColorScheme =
            darkDynamic ??
            ColorScheme.fromSeed(
              seedColor: Colors.pink,
              brightness: Brightness.dark,
            );

        return MaterialApp.router(
          title: 'TCP Penguin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          themeMode: ThemeMode.system,
          routerConfig: goRouter,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      },
    );
  }
}
