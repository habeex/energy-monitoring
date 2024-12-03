import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/data/service/monitoring_service.dart';

import 'monitoring_service_test.mocks.dart';

@GenerateMocks([MonitoringService])
@GenerateNiceMocks([MockSpec<Monitoring>()])
void main() {
  late MockMonitoringService monitoringService;

  setUp(() {
    monitoringService = MockMonitoringService();
  });

  test('Test MonitoringService returns mock data', () async {
    final List<Monitoring> generatedMockData = List.generate(
      10,
      (index) => Monitoring(timestamp: '2024-01-01', value: index),
    );

    // Define behavior of the mocked service
    when(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .thenAnswer((_) async => generatedMockData);

    final response =
        await monitoringService.getMonitoring('2024-01-01', MonitorType.solar);

    expect(response,
        equals(generatedMockData)); // Check if response matches the mock data
    expect(response.first.value, equals(0)); // Check first value
    expect(response.last.value, equals(9)); // Check last value
    verify(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .called(1); // Ensure the method is called once
  });

  test('Test MonitoringService returns empty list for failure', () async {
    // Arrange
    when(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .thenAnswer((_) async => []);

    // Act
    final response =
        await monitoringService.getMonitoring('2024-01-01', MonitorType.solar);

    // Assert
    expect(response, isEmpty); // Verify response is an empty list
    verify(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .called(1);
  });

  test('Test MonitoringService throws exception', () async {
    // Arrange
    when(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .thenThrow(Exception('Failed to fetch monitoring data'));

    // Act
    Future<void> act() async {
      await monitoringService.getMonitoring('2024-01-01', MonitorType.solar);
    }

    // Assert
    expect(act, throwsException); // Ensure an exception is thrown
    verify(monitoringService.getMonitoring('2024-01-01', MonitorType.solar))
        .called(1);
  });
}
