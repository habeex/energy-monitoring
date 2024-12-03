import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solar_monitor/data/model/monitoring.dart';

part 'monitoring_state.freezed.dart';

@freezed
class MonitoringState with _$MonitoringState {
  const factory MonitoringState.init() = MonitoringInitialState;
  const factory MonitoringState.loading() = MonitoringLoadingState;
  const factory MonitoringState.success(List<Monitoring> monitoring) =
      MonitoringSuccessState;
  const factory MonitoringState.error([dynamic error]) = MonitoringErrorState;
}
