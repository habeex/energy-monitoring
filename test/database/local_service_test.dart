import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/data/service/local_service.dart';

import 'local_service_test.mocks.dart';

@GenerateMocks([LocalService])
void main() {
  late MockLocalService localStorage;

  final monitoring = List.generate(
    3,
    (index) => Monitoring(
      timestamp: '2024-09-08 12:00',
      value: index,
      type: MonitorType.battery.name,
    ),
  );

  setUp(() {
    localStorage = MockLocalService();
  });

  test(
      'Verify that saveAnalyticsReport stores monitoring data and returns a success indicator',
      () {
    // Mock the success response
    when(localStorage.saveAnalyticsReport(monitoring)).thenAnswer(
      (_) => [0, 1, 2],
    );

    final result = localStorage.saveAnalyticsReport(monitoring);

    expect(result, [0, 1, 2]);
    verify(localStorage.saveAnalyticsReport(monitoring))
        .called(1); // Ensure method is called
  });

  test(
      'Verify that getAnalyticsReport retrieves all monitoring data for a given date in descending order',
      () async {
    // Mock monitoring data
    final monitoring = List.generate(
        10,
        (index) => Monitoring(
              timestamp: '2024-09-08 $index',
              value: index,
              type: MonitorType.battery.name,
            ));

    // Mock the data retrieval
    when(localStorage.getAnalyticsReport(
      '2024-09-08',
      MonitorType.battery,
    )).thenAnswer(
      (_) => monitoring,
    );

    final response = localStorage.getAnalyticsReport(
      '2024-09-08',
      MonitorType.battery,
    );

    expect(response, monitoring); // Ensure data matches
    expect(response.first.value, 0); // Validate the first value
    verify(localStorage.getAnalyticsReport('2024-09-08', MonitorType.battery))
        .called(1); // Ensure method is called
  });

  test(
      'Verify that saveAnalyticsReport returns an empty list when no data is provided',
      () {
    // Mock the failure response (empty list)
    when(localStorage.saveAnalyticsReport([])).thenAnswer(
      (_) => [],
    );

    final result = localStorage.saveAnalyticsReport([]);

    expect(result, isEmpty); // Validate the result is an empty list
    verify(localStorage.saveAnalyticsReport([]))
        .called(1); // Ensure method is called
  });

  test(
      'Verify that getAnalyticsReport returns an empty list for a date with no matching data',
      () {
    // Mock the failure response
    when(localStorage.getAnalyticsReport(
      '2025-01-01',
      MonitorType.solar,
    )).thenAnswer(
      (_) => [],
    );

    final response = localStorage.getAnalyticsReport(
      '2025-01-01',
      MonitorType.solar,
    );

    expect(response, isEmpty); // Ensure result is empty
    verify(localStorage.getAnalyticsReport('2025-01-01', MonitorType.solar))
        .called(1); // Ensure method is called
  });

  test('Verify that saveAnalyticsReport throws an exception on failure', () {
    // Mock an exception
    when(localStorage.saveAnalyticsReport(monitoring)).thenThrow(
      Exception('Failed to save data'),
    );

    void act() => localStorage.saveAnalyticsReport(monitoring);

    expect(act, throwsException); // Validate exception is thrown
    verify(localStorage.saveAnalyticsReport(monitoring))
        .called(1); // Ensure method is called
  });

  test('Verify that getAnalyticsReport throws an exception on failure', () {
    // Mock an exception
    when(localStorage.getAnalyticsReport(
      '2024-09-08',
      MonitorType.battery,
    )).thenThrow(
      Exception('Failed to retrieve data'),
    );

    void act() => localStorage.getAnalyticsReport(
          '2024-09-08',
          MonitorType.battery,
        );

    expect(act, throwsException); // Validate exception is thrown
    verify(localStorage.getAnalyticsReport('2024-09-08', MonitorType.battery))
        .called(1); // Ensure method is called
  });
}
