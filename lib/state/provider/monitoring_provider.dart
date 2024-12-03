import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/state/repository/monitoring_repo.dart';
import 'package:solar_monitor/state/repository/monitoring_state.dart';

final monitoringProvider =
    StateNotifierProvider<MonitoringRepo, MonitoringState>(
        (ref) => MonitoringRepo(ref));
