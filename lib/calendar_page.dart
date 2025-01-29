import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the HomePage
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 181, 212),
      body: Column(
        children: [
          // Calendar Widget
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Update focused day
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              weekendTextStyle: const TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
          // Display selected date details
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Date: ${_selectedDay?.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Show dialog or functionality to create an event
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Feature Coming Soon for $_selectedDay')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: const Color.fromARGB(255, 184, 167, 179),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            child: const Text('Create Event'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
