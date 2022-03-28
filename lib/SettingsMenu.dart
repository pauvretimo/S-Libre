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
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder3(
                          valuelistenable1: kThemedelapp,
                          valuelistenable2: kAfficheLesNoms,
                          valuelistenable3: kAfficheLesOmbres,
                          builder: (BuildContext context, ThemeMode value1,
                              bool value2, bool value3, Widget? child) {
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
                                      color: (value1 == ThemeMode.light
                                          ? Colors.yellow
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary),
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
                                      color: (value1 == ThemeMode.dark
                                          ? Colors.lightBlue
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary),
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
                                      color: (value1 == ThemeMode.system
                                          ? Colors.green
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary),
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
                                Expanded(
                                  child: ListTile(
                                    onTap: () {
                                      kAfficheLesNoms.value = !value2;
                                      saveSettings.save(
                                          'istxt', kAfficheLesNoms.value);
                                    },
                                    leading: Icon(
                                      value2
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      color:
                                          (value2 ? Colors.green : Colors.red),
                                    ),
                                    title: const Text(
                                      'Afficher le nom des salles',
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Expanded(
                                  child: ListTile(
                                    onTap: () {
                                      kAfficheLesOmbres.value = !value3;
                                      saveSettings.save(
                                          'isshadow', kAfficheLesOmbres.value);
                                    },
                                    leading: Icon(
                                      value3
                                          ? Icons.check_box_outlined
                                          : Icons.check_box_outline_blank,
                                      color:
                                          (value3 ? Colors.green : Colors.red),
                                    ),
                                    title: const Text(
                                      'Afficher les ombres des salles',
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 20),
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
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      InkWell(
                        onTap: () => showLicensePage(
                          context: context,
                          applicationName: "S-Libre",
                          applicationVersion: "1.0.1",
                          applicationLegalese: kLicence,
                        ),
                        customBorder: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 3.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: FittedBox(
                          child: Text(
                            "à propos de",
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
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      InkWell(
                        onTap: () => closer.close(),
                        customBorder: Border.all(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 3.0,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                      Expanded(
                        child: Container(),
                      ),
                    ],
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
