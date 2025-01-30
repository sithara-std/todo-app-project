import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/note_page.dart';
import 'package:myapp/todo_list_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart'; 
import 'calendar_page.dart'; 
import 'mood_tracker_screen.dart'; 
import 'reminder_page.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState(); 
}

class HomePageState extends State<HomePage> {
  
  String currentDateTime = '';
  int _currentIndex = 0; 

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yMMMd H:mm');
    return formatter.format(now);
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    currentDateTime = getCurrentDateTime();
    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currentDateTime = getCurrentDateTime();
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MoodTrackerScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReminderPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        title: const Text(
          'Welcome to the ToDo App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 233, 201, 230),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${getGreeting()}, User!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 280,
                height: 210,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/profile_picture.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'This is your personal Todo list manager. Keep track of your tasks easily and stay organized!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Current Date & Time: $currentDateTime',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TodoListScreen()),
                  );
                },
                child: const Text('Go to Todo List'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotePage()),
          );
        },
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        selectedItemColor: const Color.fromARGB(255, 13, 1, 13),
        unselectedItemColor: const Color.fromARGB(253, 246, 238, 243),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Mood Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Reminder',
          ),
        ],
      ),
    );
  }
}
