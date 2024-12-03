import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solar_monitor/core/utils/datetime_utils.dart';
import 'package:solar_monitor/core/utils/extension.dart';
import 'package:solar_monitor/data/model/measuring_unit.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/state/provider/monitoring_provider.dart';
import 'package:solar_monitor/ui/common/line_chart.dart';

class MonitoringView extends ConsumerStatefulWidget {
  const MonitoringView({super.key, required this.type});
  final MonitorType type;

  @override
  ConsumerState<MonitoringView> createState() => _MonitoringViewState();
}

class _MonitoringViewState extends ConsumerState<MonitoringView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep the widget alive

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getMonitoring();
    });
  }

  DateTime selectedDate = DateTime.now();
  MeasuringUnit _unitSelected = MeasuringUnit.Watts;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: RefreshIndicator(
        color: context.colorScheme.tertiary,
        backgroundColor: context.colorScheme.primary,
        strokeWidth: 3,
        onRefresh: () async {
          return getMonitoring();
        },
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onSelectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey,
                          width: .3,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedDate,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: .3,
                    ),
                  ),
                  child: DropdownButton<MeasuringUnit>(
                    value: _unitSelected,
                    isDense: true,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 20,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.secondary,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    autofocus: false,
                    underline: const SizedBox.shrink(),
                    items: <MeasuringUnit>[
                      MeasuringUnit.Watts,
                      MeasuringUnit.Kilowatts,
                    ].map((MeasuringUnit value) {
                      return DropdownMenuItem<MeasuringUnit>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        _unitSelected = v!;
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ref.watch(monitoringProvider).maybeMap(
                  loading: (v) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (state) {
                    return Center(
                      child: Text(
                        state.error,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                  success: (value) {
                    final sum = value.monitoring
                        .fold(0, (total, item) => total + item.value);
                    final total = _unitSelected.isWatt ? sum : sum / 1000;
                    return Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Total energy usage ',
                            style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.secondary,
                            ),
                            children: [
                              TextSpan(
                                text: '$total${_unitSelected.unit}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.secondary,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        switch (widget.type) {
                          MonitorType.solar => Chart(
                              monitoring: value.monitoring,
                              unit: _unitSelected,
                            ),
                          MonitorType.battery => CustomLineChart(
                              monitoring: value.monitoring,
                              unit: _unitSelected,
                            ),
                          MonitorType.house => Chart(
                              monitoring: value.monitoring,
                              unit: _unitSelected,
                            ),
                        }
                      ],
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
          ],
        ),
      ),
    );
  }

  void onSelectDate() {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: selectedDate,
      helpText: "Filter by date",
    ).then((result) {
      if (result != null) {
        setState(() {
          selectedDate = result;
        });
        getMonitoring();
      }
    });
  }

  String get _selectedDate => formatDate(selectedDate, format: 'yyyy-MM-dd');

  getMonitoring() => ref
      .read(monitoringProvider.notifier)
      .getMonitoring(_selectedDate, widget.type);
}
