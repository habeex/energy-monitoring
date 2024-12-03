import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitor/theme/theme_notifier.dart';
import 'package:solar_monitor/ui/app.dart';

void main() {
  testWidgets('App responds to theme changes', (WidgetTester tester) async {
    // Create a ProviderContainer to interact with the themeProvider
    final container = ProviderContainer();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const App(),
      ),
    );

    // Verify initial themeMode is ThemeMode.system
    final MaterialApp materialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.system);

    // Update the theme using the notifier
    container.read(themeProvider.notifier).updateTheme(ThemeMode.dark);
    await tester.pumpAndSettle(); // Rebuild the widget tree

    // Verify the themeMode has been updated to ThemeMode.dark
    final MaterialApp updatedMaterialApp =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(updatedMaterialApp.themeMode, ThemeMode.dark);
  });
}
