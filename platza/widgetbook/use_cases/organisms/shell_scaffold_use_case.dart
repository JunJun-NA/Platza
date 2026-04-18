import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// ShellScaffold 自体は GoRouter 依存のため、
/// Widgetbook 上では NavigationBar 部分の外観をプレビュー用に再現する。
class ShellScaffoldPreview extends StatefulWidget {
  const ShellScaffoldPreview({super.key});

  @override
  State<ShellScaffoldPreview> createState() => _ShellScaffoldPreviewState();
}

class _ShellScaffoldPreviewState extends State<ShellScaffoldPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('画面 ${_index + 1}')),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'ホーム',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: '統計',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Preview', type: ShellScaffoldPreview)
Widget shellScaffoldPreview(BuildContext context) => const ShellScaffoldPreview();
