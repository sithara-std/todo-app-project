import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/todo_list_screen.dart';
// Import Todo List Screen
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart'; // To format the current date and time
// Import the NotePage
import 'calendar_page.dart'; // Import the CalendarScreen
import 'mood_tracker_screen.dart'; // Import MoodTracker Screen
import 'reminder_page.dart'; // Import ReminderPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState(); // Change the state class to HomePageState
}

class HomePageState extends State<HomePage> {
  
  String currentDateTime = '';
  int _currentIndex = 0; // Track the current tab index

  // Function to get the current date and time
  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yMMMd H:mm');
    return formatter.format(now);
  }

  // Function to get personalized greeting based on time of day
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
    // Set up a periodic timer to update the time every minute
    Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        currentDateTime = getCurrentDateTime();
      });
    });
  }

  // Navigation handler for bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      // Navigate to Calendar Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalendarScreen()),
      );
    } else if (index == 1) {
      // Navigate to Mood Tracker Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MoodTrackerScreen()),
      );
    } else if (index == 2) {
      // Navigate to Reminder Page
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
        backgroundColor:const Color.fromARGB(255, 111, 13, 105),
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
              // Personalized Greeting
              Text(
                '${getGreeting()}, User!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // User Profile Picture (Square)
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
              // App Description
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
              // Current Date and Time
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
              // Button to navigate to Todo List
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
          // Navigate to the NotePage when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.edit), // Replace with pencil (edit) icon
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        selectedItemColor: const Color.fromARGB(255, 13, 1, 13),
        unselectedItemColor: const Color.fromARGB(137, 11, 0, 7),
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
