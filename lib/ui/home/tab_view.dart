import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:solar_monitor/data/model/monitoring_type.dart';
import 'package:solar_monitor/ui/common/custom_tab_bar.dart';
import 'package:solar_monitor/ui/monitoring/monitoring_view.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 3, vsync: this);

  final tabs = [
    const MonitoringView(type: MonitorType.solar),
    const MonitoringView(type: MonitorType.battery),
    const MonitoringView(type: MonitorType.solar),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: TabBarView(
                    controller: tabController,
                    children: tabs,
                  ),
                ),
              ),
              CustomTabBar(
                controller: tabController,
                tabPadding: const EdgeInsets.symmetric(vertical: 9),
                tabs: [
                  TabBarItem('Solar', Iconsax.sun_1_copy),
                  TabBarItem('Battery', Iconsax.battery_charging_copy),
                  TabBarItem('Home', Iconsax.house_2_copy),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
}
