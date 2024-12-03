import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/core/network/network.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/state/common/network_provider.dart';

class MonitoringService {
  final Ref? ref;

  MonitoringService(this.ref);

  Network get network => ref?.read(networkProvider) ?? Network();

  Future<List<Monitoring>> getMonitoring(String date, MonitorType type) async {
    final params = {'date': date, 'type': type.name};
    final response = await network.call(
      'monitoring',
      RequestMethod.get,
      queryParams: params,
    );
    return List<Monitoring>.from(
        response.data.map((e) => Monitoring.fromJson(e)));
  }
}

final monitoringService = Provider((ref) => MonitoringService(ref));
