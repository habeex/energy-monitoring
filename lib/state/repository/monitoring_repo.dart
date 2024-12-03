import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/data/service/local_service.dart';
import 'package:solar_monitor/data/service/monitoring_service.dart';
import 'package:solar_monitor/state/repository/monitoring_state.dart';

class MonitoringRepo extends StateNotifier<MonitoringState> {
  final Ref ref;
  MonitoringRepo(this.ref) : super(const MonitoringInitialState());
  MonitoringService get service => ref.read(monitoringService);
  LocalService get localStorage => LocalService.instance;

  Future<bool> getMonitoring(String date, MonitorType type) async {
    try {
      state = const MonitoringLoadingState();
      final localData = localStorage.getAnalyticsReport(date, type);
      if (localData.isNotEmpty) {
        state = MonitoringSuccessState(localData);
      }
      final response = await service.getMonitoring(date, type);
      if (response.isNotEmpty) {
        localStorage.saveAnalyticsReport(response);
      }
      state = MonitoringSuccessState(response);
    } catch (error) {
      state = MonitoringErrorState(error);
      return false;
    }
    return true;
  }
}
