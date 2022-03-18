import 'package:flutter/material.dart';
import 'package:learn/Globals.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:learn/SaveData.dart';

class SettingMenu extends StatelessWidget {
  @override
  const SettingMenu({
    required this.closer,
    Key? key,
  }) : super(key: key);
  final PanelController closer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 0.8,
        child: AspectRatio(
          aspectRatio: 9.0 / 16.0,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondary, width: 4.0),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).colorScheme.background),
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 300.0,
                      child: ValueListenableBuilder(
                        valueListenable: kThemedelapp,
                        builder: (BuildContext context, ThemeMode value,
                            Widget? child) {
                          return Column(
                            children: [
                              Expanded(
                                child: Container(),
                              ),
                              Expanded(
                                child: ListTile(
                                  onTap: () {
                                    kThemedelapp.value = ThemeMode.light;
                                    saveSettings.save('theme', 'light');
                                  },
                                  leading: Icon(
                                    Icons.light_mode,
                                    color: (value == ThemeMode.light
                                        ? Colors.yellow
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                  title: const Text(
                                    'Lightmode',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  onTap: () {
                                    kThemedelapp.value = ThemeMode.dark;
                                    saveSettings.save('theme', 'dark');
                                  },
                                  leading: Icon(
                                    Icons.dark_mode,
                                    color: (value == ThemeMode.dark
                                        ? Colors.lightBlue
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                  title: const Text(
                                    'Darkmode',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  onTap: () {
                                    kThemedelapp.value = ThemeMode.system;
                                    saveSettings.save('theme', 'auto');
                                  },
                                  leading: Icon(
                                    Icons.autorenew,
                                    color: (value == ThemeMode.system
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                  ),
                                  title: const Text(
                                    'Auto',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 15.0,
                  right: 15.0,
                  child: InkWell(
                    onTap: () => closer.close(),
                    customBorder: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                      width: 3.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: FittedBox(
                      child: Text(
                        "Close",
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: const Offset(0.8, 1.0),
                              blurRadius: 0.2,
                            )
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
