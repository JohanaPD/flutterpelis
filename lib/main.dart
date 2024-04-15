import 'package:flutter/material.dart';
import 'package:peliculas_flutter/providers/movies_provider.dart';
import 'package:peliculas_flutter/providers/series_provider.dart';
import 'package:peliculas_flutter/providers/user_provider.dart';
import 'package:peliculas_flutter/screens/screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SeriesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => UserProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      // initialRoute: 'home',
      // routes: {
      //   'home': (_) => const HomeScreen(),
      //   'details': (_) => const DetailsScreen(),
      // },
      initialRoute: 'login',
      routes: {
        'login': (_) => const LoginScreen(),
        'details': (_) => const DetailsScreen(),
      },
      theme: ThemeData.dark()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
