# Typing Aware Field

A Flutter package that provides a `TypingAwareTextFormField` widget to detect user typing. This widget notifies you when the user starts or stops typing, making it ideal for real-time feedback or validation.

## Features
- Detects when the user starts typing.
- Detects when the user stops typing (after a customizable timeout).
- Works on **Android**, **iOS**, and **Web**.
- Easy to integrate with existing `TextFormField` or `TextField` widgets.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  typing_aware_field: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Example
Here’s how to use the `TypingAwareTextFormField` widget:

```dart
import 'package:flutter/material.dart';
import 'package:typing_aware_field/typing_aware_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TypingAwareTextFormField(
            onTyping: (isTyping) {
              print('User is typing: $isTyping');
            },
            decoration: InputDecoration(
              labelText: 'Type something...',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
```

### Custom Timeout
You can customize the typing timeout (default is 1 second):

```dart
TypingAwareTextFormField(
  onTyping: (isTyping) {
    print('User is typing: $isTyping');
  },
  typingTimeout: Duration(milliseconds: 1500), // 1.5 seconds
)
```

### Listening to Typing Events
You can listen to typing events using the `onTyping` callback:

```dart
TypingAwareTextFormField(
  onTyping: (isTyping) {
    print('User is typing: $isTyping');
  },
)
```

## Screenshots

Here’s a screenshot of the `TypingAwareTextFormField` in action:

![typing textfield flutter](https://i.imgur.com/PHWQ22c.png)

## Platform Support
This package works on:
- **Android**
- **iOS**
- **Web**

## Contributing
Contributions are welcome! If you find a bug or want to suggest a feature, please open an issue on the [GitHub repository](https://github.com/yourusername/typing_aware_field).

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

