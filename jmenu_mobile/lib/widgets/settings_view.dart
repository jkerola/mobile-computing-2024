import 'package:flutter/material.dart';
import 'package:jmenu_mobile/models/settings_object.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Highlight allergens"),
        ),
        body: FutureBuilder(
          future: SettingsObject.loadPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              var settings = snapshot.data!;

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settings.languageCode == "en" ? "Language" : "Kieli",
                        ),
                        DropdownButton(
                            value: settings.languageCode,
                            items: [
                              DropdownMenuItem(
                                value: "en",
                                child: Text(
                                  settings.languageCode == "en"
                                      ? "English"
                                      : "Englanti",
                                ),
                              ),
                              DropdownMenuItem(
                                value: "fi",
                                child: Text(
                                  settings.languageCode == "en"
                                      ? "Finnish"
                                      : "Suomi",
                                ),
                              )
                            ],
                            onChanged: (String? val) {
                              if (val != null) {
                                settings.setLanguageCode(val);
                                setState(() {});
                              }
                            }),
                      ],
                    ),
                  ),
                  for (AllergenMarker marker in settings.markers)
                    AllergenSwitch(
                        languageCode: settings.languageCode, marker: marker)
                ],
              );
            } else {
              return const Text("Something went wrong...");
            }
          },
        ));
  }
}

class AllergenSwitch extends StatefulWidget {
  const AllergenSwitch(
      {super.key, required this.languageCode, required this.marker});

  final String languageCode;
  final AllergenMarker marker;

  @override
  State<AllergenSwitch> createState() => _AllergenSwitchState();
}

class _AllergenSwitchState extends State<AllergenSwitch> {
  late bool toggled;

  @override
  void initState() {
    super.initState();
    toggled = widget.marker.value;
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Text(
        widget.languageCode == "en"
            ? widget.marker.english
            : widget.marker.finnish,
      ),
      value: toggled,
      onChanged: (bool value) {
        widget.marker.setValue(value);
        setState(() => toggled = value);
      },
    );
  }
}
