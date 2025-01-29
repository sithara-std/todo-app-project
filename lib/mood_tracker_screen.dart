import 'package:flutter/material.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String _selectedMood = 'Happy'; // Default mood

  // Function to display the selected mood
  void _onMoodSelected(String mood) {
    setState(() {
      _selectedMood = mood;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        backgroundColor:const Color.fromARGB(255, 111, 13, 105),
        elevation: 0,
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,  // Ensure that the stack fills the entire screen
          children: [
            // Image background with color overlay
            Positioned.fill(
              child: Image.asset(
                'assets/mood.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Overlay to apply color tint to the image
            Positioned.fill(
              child: Container(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.4), // Semi-transparent overlay for color binding
              ),
            ),
            // Main content (text, buttons, etc.)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    'How are you feeling today?',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 44, 5, 37),
                      fontFamily: 'Roboto', // Custom font
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Two columns of buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // First Column
                      Column(
                        children: [
                          MoodButton(
                            mood: 'Happy',
                            icon: Icons.sentiment_satisfied,
                            color: Colors.yellow.shade700,
                            onPressed: () => _onMoodSelected('Happy'),
                          ),
                          const SizedBox(height: 15),
                          MoodButton(
                            mood: 'Sad',
                            icon: Icons.sentiment_dissatisfied,
                            color: Colors.blue.shade600,
                            onPressed: () => _onMoodSelected('Sad'),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30), // Space between columns

                      // Second Column
                      Column(
                        children: [
                          MoodButton(
                            mood: 'Angry',
                            icon: Icons.sentiment_very_dissatisfied,
                            color: Colors.red.shade600,
                            onPressed: () => _onMoodSelected('Angry'),
                          ),
                          const SizedBox(height: 15),
                          MoodButton(
                            mood: 'Excited',
                            icon: Icons.sentiment_very_satisfied,
                            color: Colors.green.shade600,
                            onPressed: () => _onMoodSelected('Excited'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Display selected mood with a smooth transition
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      'You are feeling: $_selectedMood',
                      key: ValueKey<String>(_selectedMood),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 11, 11, 11),
                        fontFamily: 'Roboto', // Custom font
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Additional details or features
                  Text(
                    'Track your mood over time and get insights into your emotional journey!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(179, 8, 8, 8),
                      fontFamily: 'Roboto', // Custom font
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom button for selecting moods with icons
class MoodButton extends StatelessWidget {
  final String mood;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const MoodButton({
    super.key,
    required this.mood,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color.fromARGB(255, 0, 0, 0),
        size: 24,
      ),
      label: Text(
        mood,
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 8, 8, 8),
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 60),
      ),
    );
  }
}
