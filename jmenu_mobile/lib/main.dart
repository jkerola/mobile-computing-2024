import 'package:flutter/material.dart';
import 'package:jmenu_mobile/menu_service.dart';
import 'package:jmenu_mobile/models/settings_object.dart';
import 'package:jmenu_mobile/widgets/date_picker_group.dart';
import 'package:jmenu_mobile/widgets/menu_list_view.dart';
import 'package:jmenu_mobile/widgets/settings_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JMenu Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MenuView(),
    );
  }
}

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  var service = MenuService();
  var date = DateTime.now();

  void openDatePicker() async {
    var newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(date.year, 1, 1),
      lastDate: DateTime(date.year, 12, 31),
      currentDate: date,
    );
    if (newDate != null) {
      setState(() => date = newDate);
    }
  }

  void openSettings() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => const SettingsView()))
        .then((_) => setState(() {}));
  }

  void increaseDate() {
    setState(() => date = date.add(const Duration(days: 1)));
  }

  void decreaseDate() {
    setState(() => date = date.subtract(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("JMenu Mobile"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openSettings,
        child: const Icon(Icons.menu),
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
            return Column(
              children: [
                DatePickerGroup(
                  decreaseDate: decreaseDate,
                  increaseDate: increaseDate,
                  openDatePicker: openDatePicker,
                  date: date,
                ),
                FutureBuilder(
                  future: SettingsObject.loadPreferences(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      var settings = snapshot.data!;
                      return Expanded(
                        child: MenuListView(
                          date: date,
                          languageCode: settings.languageCode,
                          settings: settings,
                        ),
                      );
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Something went terribly wrong."),
            );
          }
        },
      ),
    );
  }
}
