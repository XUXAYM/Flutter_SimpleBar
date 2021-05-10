import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/settings_notifier.dart';
import 'page.dart';

class SettingsPage extends StatelessWidget with PageWithTitle {
  SettingsPage({this.title: ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, settingsData, _) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Theme:'),
                SizedBox(width: 8.0,),
                DropdownButton<ThemeMode>(
                  value: settingsData.mode,
                  onChanged: (mode) => settingsData.mode = mode,
                  items: ThemeMode.values.map<DropdownMenuItem<ThemeMode>>(
                        (mode) => DropdownMenuItem(
                      child: Text(describeEnum(mode)),
                      value: mode,
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
