import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/theme/theme.dart';
import 'package:solar_monitor/theme/theme_notifier.dart';
import 'package:solar_monitor/ui/home/home_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Builder(builder: (context) {
      return MaterialApp(
        title: 'Monitoring App',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: theme,
        home: const HomeScreen(),
      );
    });
  }
}
