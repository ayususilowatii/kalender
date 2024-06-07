import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KalenderPage extends StatefulWidget {
  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  DateTime _selectedDate = DateTime.now();

  void _previousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1);
    });
  }

  List<Widget> _buildDaysOfWeek() {
    final daysOfWeek = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return daysOfWeek.map((day) => dayCell(day)).toList();
  }

  List<TableRow> _buildCalendarDays() {
    List<TableRow> rows = [];
    List<Widget> dayWidgets = [];
    DateTime firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    int daysInMonth = DateUtils.getDaysInMonth(_selectedDate.year, _selectedDate.month);
    int startingWeekday = firstDayOfMonth.weekday % 7;

    // Add empty cells for days before the first of the month
    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(dateCell(''));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(dateCell(day.toString(), highlight: day == 3 && _selectedDate.month == 7));
      if (dayWidgets.length == 7) {
        rows.add(TableRow(children: List.from(dayWidgets)));
        dayWidgets.clear();
      }
    }

    // Add empty cells for the remaining days in the last week
    if (dayWidgets.isNotEmpty) {
      while (dayWidgets.length < 7) {
        dayWidgets.add(dateCell(''));
      }
      rows.add(TableRow(children: List.from(dayWidgets)));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    String monthYear = DateFormat.yMMMM().format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.arrow_back), onPressed: _previousMonth),
                Text(
                  monthYear,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(icon: Icon(Icons.arrow_forward), onPressed: _nextMonth),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              children: [
                TableRow(
                  children: _buildDaysOfWeek(),
                ),
                ..._buildCalendarDays(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.orange),
                  title: Text(
                    'Blue Day',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dayCell(String day) {
    return Center(
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget dateCell(String date, {bool highlight = false}) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: highlight ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date,
            style: TextStyle(
              color: highlight ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
