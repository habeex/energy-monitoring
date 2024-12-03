import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:solar_monitor/core/utils/extension.dart';
import 'package:solar_monitor/theme/theme_notifier.dart';
import 'package:solar_monitor/ui/home/tab_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.inversePrimary,
        title: Text(
          'Monitoring',
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              final theme = ref.read(themeProvider);
              if (theme == ThemeMode.light) {
                ref.read(themeProvider.notifier).updateTheme(ThemeMode.dark);
              } else {
                ref.read(themeProvider.notifier).updateTheme(ThemeMode.light);
              }
            },
            icon: const Icon(Iconsax.moon_copy),
          )
        ],
      ),
      body: const TabView(),
    );
  }
}
