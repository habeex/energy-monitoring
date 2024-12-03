// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Monitoring _$MonitoringFromJson(Map<String, dynamic> json) => Monitoring(
      timestamp: json['timestamp'] as String,
      value: (json['value'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MonitoringToJson(Monitoring instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'value': instance.value,
    };
