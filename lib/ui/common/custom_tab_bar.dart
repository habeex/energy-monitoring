import 'package:flutter/material.dart';
import 'package:solar_monitor/core/utils/extension.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.tabPadding,
  });
  final TabController? controller;
  final List<TabBarItem> tabs;
  final EdgeInsets? tabPadding;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  TabController? _controller;
  int? _currentIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    assert(debugCheckHasMaterial(context));
    _updateTabController();
  }

  void _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.of(context);
    assert(() {
      if (newController == null) {
        throw FlutterError(
          'No TabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must either provide an explicit '
          'TabController using the "controller" property, or you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.\n'
          'In this case, there was neither an explicit controller nor a default controller.',
        );
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    _controller = newController;
    if (_controller != null) {
      _controller!.addListener(_handleTabControllerTick);
      _currentIndex = _controller!.index;
    }
  }

  void _handleTabControllerTick() {
    if (_controller!.index != _currentIndex) {
      _currentIndex = _controller!.index;
    }
    setState(() {
      // Rebuild the tabs after a (potentially animated) index change
      // has completed.
    });
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.tabs.length);
    _controller!.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> wrappedTabs =
        List<Widget>.generate(widget.tabs.length, (int index) {
      return _tab(
        widget.tabs[index],
        index,
        index == _currentIndex,
      );
    });

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: wrappedTabs,
      ),
    );
  }

  _tab(TabBarItem item, int index, bool selected) => Expanded(
        child: InkWell(
          onTap: () {
            _handleTap(index);
          },
          child: Container(
            padding: widget.tabPadding ??
                const EdgeInsets.symmetric(
                  vertical: 16,
                ),
            decoration: BoxDecoration(
              color: selected ? context.colorScheme.tertiary : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: selected ? context.colorScheme.primary : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  item.title,
                  style: TextStyle(
                    color: selected ? context.colorScheme.primary : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class TabBarItem {
  final String title;
  final IconData icon;

  TabBarItem(this.title, this.icon);
}
