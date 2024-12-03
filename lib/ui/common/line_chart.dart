import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_monitor/core/utils/extension.dart';
import 'package:solar_monitor/data/model/measuring_unit.dart';
import 'package:solar_monitor/data/model/monitoring.dart';
import 'package:solar_monitor/ui/common/chart_title.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.monitoring, required this.unit});
  final List<Monitoring> monitoring;
  final MeasuringUnit unit;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Monitoring> get monitoring => widget.monitoring;

  List<FlSpot> listData(List<Monitoring> data) {
    return data
        .mapIndexed(
          (e, i) => FlSpot(
              i.toDouble(),
              widget.unit.isWatt
                  ? e.value.toDouble()
                  : e.value.toDouble() / 1000),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return AspectRatio(
      aspectRatio: .9,
      child: LineChart(
        LineChartData(
          clipData: const FlClipData.all(),
          minX: 0,
          maxX: monitoring.isEmpty ? 0 : (monitoring.length.toDouble() - 1),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (v) {
              return FlLine(
                color: Colors.grey.shade400,
                strokeWidth: 0.2,
                dashArray: [10, 8, 10, 8, 10, 8, 10],
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 100,
                getTitlesWidget: (value, meta) => ChartBottomTitle(
                  monitoring: monitoring,
                  value: value,
                  meta: meta,
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: widget.unit.isWatt ? 45 : 30,
                getTitlesWidget: (value, meta) => ChartLeftTitle(
                  value: value,
                  meta: meta,
                ),
              ),
              axisNameWidget: Text(
                widget.unit.name,
                style: TextStyle(
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: <LineChartBarData>[
            LineChartBarData(
              spots: listData(monitoring),
              isCurved: true,
              color: colorScheme.primary.withOpacity(0.9),
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withOpacity(.6),
                    colorScheme.primary.withOpacity(.3),
                  ],
                  stops: const <double>[0.0, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomLineChart extends StatefulWidget {
  const CustomLineChart({
    super.key,
    Color? gradientColor1,
    Color? gradientColor2,
    Color? gradientColor3,
    Color? indicatorStrokeColor,
    required this.monitoring,
    required this.unit,
  })  : gradientColor1 = gradientColor1 ?? Colors.blue,
        gradientColor2 = gradientColor2 ?? Colors.pink,
        gradientColor3 = gradientColor3 ?? Colors.red,
        indicatorStrokeColor = indicatorStrokeColor ?? Colors.orangeAccent;

  final Color gradientColor1;
  final Color gradientColor2;
  final Color gradientColor3;
  final Color indicatorStrokeColor;

  final List<Monitoring> monitoring;
  final MeasuringUnit unit;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<int> showingTooltipOnSpots = [];

  List<Monitoring> get monitoring => widget.monitoring;

  List<FlSpot> listData(List<Monitoring> data) {
    return data
        .mapIndexed(
          (e, i) => FlSpot(
              i.toDouble(),
              widget.unit.isWatt
                  ? e.value.toDouble()
                  : e.value.toDouble() / 1000),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: listData(monitoring),
        isCurved: true,
        barWidth: 4,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              Colors.orangeAccent.withOpacity(0.4),
              Colors.pink.withOpacity(0.4),
              Colors.red.withOpacity(0.4),
            ],
          ),
        ),
        dotData: const FlDotData(show: false),
        gradient: const LinearGradient(
          colors: [
            Colors.orangeAccent,
            Colors.pink,
            Colors.red,
          ],
          stops: [0.1, 0.4, 0.9],
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];
    return AspectRatio(
      aspectRatio: .9,
      child: LineChart(
        LineChartData(
          clipData: const FlClipData.all(),
          minX: 0,
          maxX: monitoring.isEmpty ? 0 : (monitoring.length.toDouble() - 1),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (v) {
              return FlLine(
                color: Colors.grey.shade400,
                strokeWidth: 0.2,
                dashArray: [10, 8, 10, 8, 10, 8, 10],
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 100,
                getTitlesWidget: (value, meta) => ChartBottomTitle(
                  monitoring: monitoring,
                  value: value,
                  meta: meta,
                ),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: widget.unit.isWatt ? 45 : 30,
                getTitlesWidget: (value, meta) => ChartLeftTitle(
                  value: value,
                  meta: meta,
                ),
              ),
              axisNameWidget: Text(
                widget.unit.name,
                style: TextStyle(
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          lineBarsData: lineBarsData,
          showingTooltipIndicators: showingTooltipOnSpots.map((index) {
            return ShowingTooltipIndicators([
              LineBarSpot(
                tooltipsOnBar,
                lineBarsData.indexOf(tooltipsOnBar),
                tooltipsOnBar.spots[index],
              ),
            ]);
          }).toList(),
          lineTouchData: LineTouchData(
            enabled: true,
            handleBuiltInTouches: false,
            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
              if (response == null || response.lineBarSpots == null) {
                return;
              }
              if (event is FlTapUpEvent) {
                final spotIndex = response.lineBarSpots!.first.spotIndex;
                setState(() {
                  if (showingTooltipOnSpots.contains(spotIndex)) {
                    showingTooltipOnSpots.remove(spotIndex);
                  } else {
                    showingTooltipOnSpots.add(spotIndex);
                  }
                });
              }
            },
            mouseCursorResolver:
                (FlTouchEvent event, LineTouchResponse? response) {
              if (response == null || response.lineBarSpots == null) {
                return SystemMouseCursors.basic;
              }
              return SystemMouseCursors.click;
            },
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  const FlLine(
                    color: Colors.indigoAccent,
                  ),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 8,
                      color: lerpGradient(
                        barData.gradient!.colors,
                        barData.gradient!.stops!,
                        percent / 100,
                      ),
                      strokeWidth: 2,
                      strokeColor: Colors.indigoAccent,
                    ),
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => Colors.indigoAccent,
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                return lineBarsSpot.map((lineBarSpot) {
                  return LineTooltipItem(
                    lineBarSpot.y.toString(),
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s];
    final rightStop = stops[s + 1];
    final leftColor = colors[s];
    final rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
