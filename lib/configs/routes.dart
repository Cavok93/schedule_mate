import 'package:flutter/material.dart';
import 'package:today_mate_clean/domain/entities/schedule/schedule.dart';
import 'package:today_mate_clean/presenter/screens/home/sections/app_themes.dart';
import 'package:today_mate_clean/presenter/screens/splash/splash.dart';

import '../core/fade_page_route.dart';
import '../presenter/screens/home/home.dart';

import '../presenter/screens/home/sections/compose.dart';

enum Routes { splash, home, form, themes }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String form = '/home/form';
  static const String themes = '/home/themes';
  // static const String typeEffectsScreen = '/home/type';
  // static const String itemsList = '/home/items';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.form: _Paths.form,
    Routes.themes: _Paths.themes,
    // Routes.pokemonInfo: _Paths.pokemonInfo,
    // Routes.typeEffects: _Paths.typeEffectsScreen,
    // Routes.items: _Paths.itemsList
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case _Paths.themes:
        return MaterialPageRoute(builder: (context) => const AppThemesScreen());

      case _Paths.form:
        return MaterialPageRoute(
            builder: (context) => ComposeScreen(
                targetSchedule: (settings.arguments != null)
                    ? (settings.arguments as Schedule)
                    : null));
      case _Paths.home:
      default:
        return FadeRoute(page: const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
