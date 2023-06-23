import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/config/themes/app_theme.dart';
import 'package:test_app/presentation/states/auth_provider.dart';
import 'package:test_app/presentation/views/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeModel>(
            create: (_) => ThemeModel(theme: ThemeModel.light)),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<ThemeData> initializeApp(BuildContext context) async {
    ///Check dark mode
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = false;
    if (prefs.containsKey('isDark')) {
      isDark = prefs.getBool('isDark') ?? true;
    }

    return (isDark) ? ThemeModel.dark : ThemeModel.light;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeData>(
      future: initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return MaterialApp(
              theme: ThemeModel.dark,
              debugShowCheckedModeBanner: false,
              home: const SignInScreen(),
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                ),
              ),
            );
          }
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
