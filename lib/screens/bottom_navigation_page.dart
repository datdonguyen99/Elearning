import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:elearning/extensions/l10n.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  final _selectedIdx = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NavigationBar(
            selectedIndex: _selectedIdx.value,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (idx) {
              widget.child.goBranch(
                idx,
                initialLocation: idx == widget.child.currentIndex,
              );
              setState(() {
                _selectedIdx.value = idx;
              });
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(FluentIcons.home_24_regular),
                selectedIcon: const Icon(FluentIcons.home_24_filled),
                label: context.l10n?.home ?? 'Home',
              ),
              NavigationDestination(
                icon: const Icon(FluentIcons.settings_24_regular),
                selectedIcon: const Icon(FluentIcons.settings_24_filled),
                label: context.l10n?.setting ?? 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
