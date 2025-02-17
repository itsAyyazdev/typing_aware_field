import 'package:flutter/material.dart';
import 'package:typing_aware_field/typing_aware_field.dart'; // Import your plugin

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Aware Field Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TypingAwareFieldDemo(),
    );
  }
}

class TypingAwareFieldDemo extends StatefulWidget {
  const TypingAwareFieldDemo({super.key});

  @override
  State<TypingAwareFieldDemo> createState() => _TypingAwareFieldDemoState();
}

class _TypingAwareFieldDemoState extends State<TypingAwareFieldDemo> {
  bool _isTyping = false; // State to track typing status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Typing Aware Field Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _isTyping ? 'Typing...' : 'Not typing',
              style: TextStyle(
                fontSize: 24,
                color: _isTyping ? Colors.green : Colors.grey,
              ),
            ),
            SizedBox(height: 20), // Spacer
            // TypingAwareTextFormField
            TypingAwareTextFormField(
              onTyping: (isTyping) {
                setState(() {
                  _isTyping = isTyping; // Update typing status
                });
              },
              decoration: InputDecoration(
                labelText: 'Type something...',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                debugPrint('User typed: $text');
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
