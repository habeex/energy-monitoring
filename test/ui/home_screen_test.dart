import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/theme/theme_notifier.dart';
import 'package:solar_monitor/ui/home/home_screen.dart';
import 'package:solar_monitor/ui/home/tab_view.dart';
import 'package:solar_monitor/ui/monitoring/monitoring_view.dart';

void main() {
  group('Tests HomeScreen and TabView Widget', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('AppBar displays correct title and toggles theme',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      // Verify AppBar title
      expect(find.text('Monitoring'), findsOneWidget);

      // Verify AppBar action button is present
      expect(find.byIcon(Iconsax.moon_copy), findsOneWidget);

      // Initially, themeProvider is set to system (default state)
      final initialTheme = container.read(themeProvider);
      expect(initialTheme, ThemeMode.system);

      // Simulate theme toggle (from system to light)
      await tester.tap(find.byIcon(Iconsax.moon_copy));
      await tester.pumpAndSettle(); // Allow state update
      final updatedTheme = container.read(themeProvider);
      expect(updatedTheme, ThemeMode.light);

      // Toggle again (from light to dark)
      await tester.tap(find.byIcon(Iconsax.moon_copy));
      await tester.pumpAndSettle();
      final darkTheme = container.read(themeProvider);
      expect(darkTheme, ThemeMode.dark);
    });

    testWidgets('TabView initializes with correct tabs and displays content',
        (WidgetTester tester) async {
      // Wrap with ProviderScope
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: TabView(),
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.text('Solar'), findsOneWidget);
      expect(find.text('Battery'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);

      // Verify the first tab is selected by default
      expect(find.byType(MonitoringView), findsOneWidget);
      final MonitoringView firstTabView =
          tester.widget(find.byType(MonitoringView));
      expect(firstTabView.type, MonitorType.solar);

      // Switch to the second tab (Battery)
      await tester.tap(find.text('Battery'));
      await tester.pumpAndSettle();

      // Verify the second tab content
      final MonitoringView secondTabView =
          tester.widget(find.byType(MonitoringView));
      expect(secondTabView.type, MonitorType.battery);

      // Switch to the third tab (Home)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify the third tab content (also Solar for testing purposes)
      final MonitoringView thirdTabView =
          tester.widget(find.byType(MonitoringView));
      expect(thirdTabView.type, MonitorType.solar);
    });
  });
}
