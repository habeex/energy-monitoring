import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_monitor/core/utils/datetime_utils.dart';
import 'package:solar_monitor/core/utils/extension.dart';
import 'package:solar_monitor/data/model/monitoring.dart';

class ChartBottomTitle extends StatelessWidget {
  const ChartBottomTitle({
    super.key,
    required this.monitoring,
    required this.value,
    required this.meta,
  });
  final List<Monitoring> monitoring;
  final double value;
  final TitleMeta meta;
  @override
  Widget build(BuildContext context) {
    int index = value.toInt();
    String date = index >= 0 && index < monitoring.length
        ? monitoring[index].timestamp
        : '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Transform.rotate(
          angle: -3.14159 / 2,
          child: Text(
            formatStringDate(date, format: 'HH:mm a'),
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}

class ChartLeftTitle extends StatelessWidget {
  const ChartLeftTitle({
    super.key,
    required this.value,
    required this.meta,
  });
  final double value;
  final TitleMeta meta;
  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text(
          '${value.toInt()}',
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
