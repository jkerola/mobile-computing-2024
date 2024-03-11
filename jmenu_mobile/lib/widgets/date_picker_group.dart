import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerGroup extends StatelessWidget {
  const DatePickerGroup({
    super.key,
    required this.decreaseDate,
    required this.increaseDate,
    required this.openDatePicker,
    required this.date,
  });
  final DateTime date;
  final Function() decreaseDate;
  final Function() increaseDate;
  final Function() openDatePicker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: decreaseDate,
            child: const Icon(Icons.arrow_left),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: OutlinedButton(
              onPressed: openDatePicker,
              child: Text(
                DateFormat("yMd").format(date),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: increaseDate,
            child: const Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
