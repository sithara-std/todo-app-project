import 'package:flutter/material.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Page'),
        backgroundColor: const Color.fromARGB(255, 111, 13, 105),
        elevation: 0,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Your image here
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                // ignore: deprecated_member_use
                color:const Color.fromARGB(255, 233, 201, 230), // Dark overlay for contrast
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Header
                  Text(
                    'Your Reminders',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 14, 13, 13),
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Reminder Cards (mock data for now)
                  Expanded(
                    child: ListView(
                      children: [
                        _buildReminderCard('Morning Workout', '10:00 AM'),
                        _buildReminderCard('Meeting with Team', '2:00 PM'),
                        _buildReminderCard('Dinner with Friends', '7:00 PM'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating action button for settings
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to settings page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
                backgroundColor: Colors.purpleAccent,
                child: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a reminder card
  Widget _buildReminderCard(String title, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          Icons.alarm,
          color: Colors.deepPurpleAccent,
          size: 40,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(time),
      ),
    );
  }
}

// Settings Page (simple example)
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: const Center(
        child: Text('Settings Content Here'),
      ),
    );
  }
}
