import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'package:uchiha_saving/screens/landing_screen/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: "light",
      themes: [
        AppTheme.light(
            id: "light"), // This is standard light theme (id is default_light_theme)
        AppTheme.dark(
            id: "dark"), // This is standard dark theme (id is default_dark_theme)
      ],
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            home:
                //BasicPage(),
                LandingScreen(),
          ),
        ),
      ),
    );
  }
}
