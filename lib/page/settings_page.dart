import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/provider/settings_notifier.dart';
import 'page.dart';

class SettingsPage extends StatelessWidget with PageWithTitle {
  SettingsPage({this.title: ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, settingsData, _) => Column(
        children: [
          Row(
            children: [
              Text('Theme:'),
              DropdownButton<ThemeMode>(
                value: settingsData.mode,
                onChanged: (mode) => settingsData.mode = mode,
                items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>(
                      (mode) => DropdownMenuItem(
                    child: Text(mode.toString()),
                    value: mode,
                  ),
                ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
